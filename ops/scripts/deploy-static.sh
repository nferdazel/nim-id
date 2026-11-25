#!/usr/bin/env bash
# deploy-static.sh — render & pasang situs buku di VPS (nim.qouver.com).
#
# Dipanggil webhook adnanh/webhook dengan argumen:
#   $1 = repository.name ("nim-id")
#   $2 = ref              ("refs/heads/main")
#
# Berbeda dari deploy service: tidak ada podman, tidak ada tag :local/:prev,
# tidak ada migrasi. Yang dipertahankan dari kontrak: ref-guard fail-closed,
# flock, fetch/reset idempoten, swap berbasis symlink, health check.
# Tambahan khusus situs statis: deploy menunggu check `Gate` untuk SHA itu.
#
# Rollback: symlink `current` menunjuk satu direktori rilis. `previous` menyimpan
# rilis sebelumnya. Kalau health check gagal, symlink dikembalikan ke `previous`.
set -euo pipefail

REPO="${1:-nim-id}"
REF="${2:-}"

APP_DIR="${NIMID_APP_DIR:-/srv/qouver/apps/nim-id}"
MONO_DIR="$APP_DIR/monorepo"
WEB_LINK="$APP_DIR/web"
RILIS_DIR="$APP_DIR/releases"
SIMPAN=3
QUARTO="${QUARTO:-$APP_DIR/.tools/quarto/bin/quarto}"
LOG="$APP_DIR/logs/deploy.log"
# Health check lewat nama publik, bukan loopback. Tabel nft `inet cfedge`
# membuang tcp 80/443 dari sumber selain rentang Cloudflare, termasuk 127.0.0.1,
# jadi curl ke loopback selalu timeout (kode 000) dan bukan lagi sinyal yang sah.
# Nama publik menempuh jalur sebenarnya: Cloudflare -> AOP -> Caddy -> web.
HEALTH_URL="${NIMID_HEALTH_URL:-https://nim.qouver.com/}"

mkdir -p "$APP_DIR/logs" "$RILIS_DIR"

# Retensi: sisakan $SIMPAN rilis terbaru, jangan pernah hapus rilis yang sedang aktif.
bersihkan_rilis() {
  local aktif
  aktif="$(readlink -f "$WEB_LINK" 2>/dev/null || true)"
  ls -1dt "$RILIS_DIR"/*/ 2>/dev/null | tail -n +"$((SIMPAN + 1))" | while read -r lama; do
    [ "$(readlink -f "$lama")" = "$aktif" ] && continue
    log "==> hapus rilis lama: $lama"
    rm -rf "$lama"
  done
}

log() { printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG"; }
die() { log "ERROR: $*"; exit 1; }

# CI gate: webhook datang bersamaan dengan GitHub Actions, jadi deploy menunggu check
# `Gate` untuk SHA yang akan dipasang, bukan menebak. Fail-closed: CI merah, tidak ada
# check, atau lewat batas waktu berarti situs lama tetap hidup.
GATE_TIMEOUT="${NIMID_GATE_TIMEOUT:-1200}" # detik
GATE_POLL="${NIMID_GATE_POLL:-30}"         # detik

tunggu_gate() {
  local sha="$1" batas state auth=()
  command -v python3 >/dev/null 2>&1 || die "python3 tidak ada: tidak bisa membaca status CI"
  [ -n "${NIMID_GITHUB_TOKEN:-}" ] && auth=(-H "Authorization: Bearer $NIMID_GITHUB_TOKEN")
  batas=$(( $(date +%s) + GATE_TIMEOUT ))
  while :; do
    state=$(curl -fsS --max-time 15 "${auth[@]}" \
      -H 'Accept: application/vnd.github+json' \
      "https://api.github.com/repos/nferdazel/nim-id/commits/$sha/check-runs" 2>/dev/null \
      | python3 -c '
import json, sys
sha = sys.argv[1]
try:
    data = json.load(sys.stdin)
except Exception:
    print("unavailable")
    sys.exit()
runs = [r for r in data.get("check_runs", [])
        if r.get("name") == "Gate" and r.get("head_sha") == sha]
if not runs:
    print("pending")
elif any(r.get("status") != "completed" for r in runs):
    print("pending")
elif any(r.get("conclusion") == "success" for r in runs):
    print("success")
else:
    print(runs[-1].get("conclusion") or "failure")
' "$sha" 2>/dev/null) || state="unavailable"

    case "$state" in
      success)
        log "==> CI Gate lulus untuk $sha"
        return 0
        ;;
      pending | unavailable)
        if [ "$(date +%s)" -ge "$batas" ]; then
          die "CI Gate belum lulus untuk $sha setelah ${GATE_TIMEOUT}s: deploy dibatalkan"
        fi
        log "==> menunggu CI Gate untuk $sha ($state)"
        sleep "$GATE_POLL"
        ;;
      *)
        die "CI Gate berstatus '$state' untuk $sha: deploy dibatalkan"
        ;;
    esac
  done
}

# 1. Ref-guard fail-closed. Hanya main.
if [ "$REF" != "refs/heads/main" ]; then
  log "Deploy diabaikan: ref '$REF' bukan refs/heads/main"
  exit 0
fi

# 2. Kunci: dua deploy bersamaan akan saling menimpa swap.
exec 9>/tmp/deploy-nimid.lock
if ! flock -w 1200 9; then
  log "Deploy lain sedang berjalan. Keluar."
  exit 1
fi

[ -x "$QUARTO" ] || die "Quarto tidak ada di $QUARTO"

# 3. Sinkronisasi repo, tahan force-push.
cd "$MONO_DIR" || die "monorepo tidak ada di $MONO_DIR"
git fetch --prune origin main
git reset --hard origin/main
REV="$(git rev-parse --short HEAD)"
log "==> konten di $REV"

# Hanya commit yang sudah lulus check `Gate` di GitHub Actions boleh dirender.
# Override manual hanya untuk keadaan darurat, dan tercatat di log.
if [ "${NIMID_SKIP_GATE:-0}" = "1" ]; then
  log "WARN: NIMID_SKIP_GATE=1, check CI dilewati (deploy manual)"
else
  tunggu_gate "$(git rev-parse HEAD)"
fi

# 4. Render kedua bahasa + susun public/. PDF ikut dibangun render yang sama.
QUARTO="$QUARTO" bash tools/build-site.sh 2>&1 | tee -a "$LOG" || die "render gagal"
[ -f "public/index.html" ] || die "hasil render tidak berisi index.html"

# 5. Pasang ke direktori rilis, lalu swap symlink.
BARU="$RILIS_DIR/$REV"
rm -rf "$BARU"
mkdir -p "$BARU"
rsync -a --delete public/ "$BARU/"
restorecon -RF "$BARU" 2>/dev/null || log "WARN: restorecon dilewati (bukan root?)"

if [ -L "$WEB_LINK" ]; then
  IKUTI="$(readlink -f "$WEB_LINK")"
  ln -sfn "$IKUTI" "$APP_DIR/.previous"
fi
ln -sfn "$BARU" "$WEB_LINK"
log "==> symlink web -> $BARU"

# 6. Health check: routing Caddy + isi rilis di disk, dengan retry.
# Gagal berarti kembalikan symlink lama.
sehat=0
for i in 1 2 3 4 5; do
  kode=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 \
           "$HEALTH_URL" || echo "000")
  if { [ "$kode" = "200" ] || [ "$kode" = "308" ]; } \
      && grep -q "Dasar Pemrograman Nim" "$BARU/index.html" \
      && grep -q "Learning Nim" "$BARU/en/index.html"; then
    sehat=1
    break
  fi
  log "health check percobaan $i gagal (HTTP $kode), ulangi 2 detik"
  sleep 2
done

if [ "$sehat" -ne 1 ]; then
  kode=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 "$HEALTH_URL" || echo "000")
  log "Health check GAGAL di $HEALTH_URL (kode $kode)"
  if [ -e "$APP_DIR/.previous" ]; then
    ln -sfn "$(readlink -f "$APP_DIR/.previous")" "$WEB_LINK"
    log "Rollback: symlink web dipulihkan"
  fi
  bersihkan_rilis
  exit 1
fi
log "==> health check lolos"

# 7. Retensi.
bersihkan_rilis

# 8. Self-update: skrip ini ikut repo, salin versi terbaru untuk deploy berikutnya.
if [ -f "$MONO_DIR/ops/scripts/deploy-static.sh" ] && ! cmp -s "$MONO_DIR/ops/scripts/deploy-static.sh" "$APP_DIR/scripts/deploy-static.sh"; then
  install -m 755 "$MONO_DIR/ops/scripts/deploy-static.sh" "$APP_DIR/scripts/deploy-static.sh"
  log "==> skrip deploy diperbarui dari repo"
fi

printf '%s\n' "$REV" >"$APP_DIR/.deployed_rev"
log "==> selesai: $REV"
