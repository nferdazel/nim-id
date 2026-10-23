#!/usr/bin/env bash
# setup-vps.sh — penyiapan sekali jalan untuk nim.qouver.com. HARUS dijalankan sebagai root
# (`sudo bash setup-vps.sh`). Idempoten: aman dijalankan dua kali.
#
# Yang dikerjakan:
#   1. label SELinux untuk /srv/qouver/apps/nim-id
#   2. menambahkan blok Caddy (kalau belum ada), dengan cadangan bertanggal
#   3. validasi + reload Caddy
#
# Tidak menyentuh firewall, DNS, atau konfigurasi lain.
set -euo pipefail

APP="${NIMID_APP_DIR:-/srv/qouver/apps/nim-id}"
BLOCK="$APP/Caddyfile.nim-id.block"
CADDY="${NIMID_CADDYFILE:-/etc/caddy/Caddyfile}"

[ "$(id -u)" -eq 0 ] || { echo "harus root"; exit 1; }
[ -f "$BLOCK" ] || { echo "blok Caddy tidak ada: $BLOCK"; exit 1; }

echo "==> 1/3 label SELinux"
if semanage fcontext -l | grep -q '^/srv/qouver/apps/nim-id'; then
  echo "    aturan fcontext sudah ada"
else
  semanage fcontext -a -t httpd_sys_content_t '/srv/qouver/apps/nim-id(/.*)?'
  echo "    aturan fcontext ditambahkan"
fi
restorecon -RF "$APP"
echo "    label sekarang: $(ls -Zd "$APP/web" | awk '{print $1}')"

echo "==> 2/3 blok Caddy"
if grep -q '^nim\.qouver\.com {' "$CADDY"; then
  echo "    blok sudah ada, tidak diubah"
else
  BAK="$CADDY.bak-$(date +%F-%H%M%S)"
  cp -a "$CADDY" "$BAK"
  echo "    cadangan: $BAK"
  # Pastikan berkas lama berakhir dengan newline sebelum ditambahi.
  [ -n "$(tail -c 1 "$CADDY")" ] && printf '\n' >>"$CADDY"
  cat "$BLOCK" >>"$CADDY"
  echo "    blok ditambahkan"
fi

echo "==> 3/3 validasi + terapkan"
if ! caddy validate --config "$CADDY" --adapter caddyfile >/tmp/caddy-validate.log 2>&1; then
  echo "    VALIDASI GAGAL. Konfigurasi TIDAK diterapkan."
  tail -20 /tmp/caddy-validate.log
  exit 1
fi
# Caddyfile ini memakai `admin off` (audit H-5), jadi `caddy reload` mustahil:
# tidak ada endpoint admin yang bisa dikirimi config. Restart singkat (~1 detik),
# semua situs lain ikut turun-naik. Jangan ganti ke reload tanpa menghidupkan admin.
systemctl restart caddy
sleep 2
systemctl is-active --quiet caddy || { echo "    caddy tidak aktif setelah restart"; exit 1; }
echo "    caddy di-restart"

echo "==> selesai. Uji dari luar: curl -sI https://nim.qouver.com | head -3"
