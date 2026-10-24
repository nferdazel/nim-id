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
HEALTH_URL="${NIMID_HEALTH_URL:-https://nim.qouver.com/}"
# Uji origin langsung, bukan lewat Cloudflare: request dari VPS ke edge sendiri rawan
# hairpin/timeout dan bukan yang sedang kita jamin. CF diuji terpisah dari luar.
HEALTH_RESOLVE="${NIMID_HEALTH_RESOLVE:-127.0.0.1}"
HEALTH_BODY="$APP_DIR/logs/health.html"

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

# 1. Ref-guard fail-closed. Hanya main.
if [ "$REF" != "refs/heads/main" ]; then
  log "Deploy diabaikan: ref '$REF' bukan refs/heads/main"
  exit 0
fi

# 2. Kunci: dua deploy bersamaan akan saling menimpa swap.
exec 9>/tmp/deploy-nimid.lock
if ! flock -n 9; then
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

# 6. Health check ke origin, dengan retry. Gagal berarti kembalikan symlink lama.
# Body ditulis ke berkas dulu: `curl | grep -q` membuat grep keluar lebih awal, curl kena
# SIGPIPE (exit 23), dan `pipefail` menandai pipeline gagal padahal isinya benar.
sehat=0
for i in 1 2 3 4 5; do
  if curl -fsS --max-time 10 --resolve "nim.qouver.com:443:$HEALTH_RESOLVE" -o "$HEALTH_BODY" "$HEALTH_URL" \
      && grep -q "Dasar Pemrograman Nim" "$HEALTH_BODY" \
      && curl -fsS --max-time 10 --resolve "nim.qouver.com:443:$HEALTH_RESOLVE" -o "$HEALTH_BODY.en" "${HEALTH_URL}en/" \
      && grep -q "Learning Nim" "$HEALTH_BODY.en"; then
    sehat=1
    break
  fi
  log "health check percobaan $i gagal, ulangi 2 detik"
  sleep 2
done

if [ "$sehat" -ne 1 ]; then
  kode=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 --resolve "nim.qouver.com:443:$HEALTH_RESOLVE" "$HEALTH_URL" || echo "000")
  log "Health check GAGAL di $HEALTH_URL (origin $HEALTH_RESOLVE, kode $kode)"
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
