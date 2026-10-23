#!/usr/bin/env bash
# Render kedua buku dan susun satu direktori siap-deploy:
#   public/         → Indonesia (akar situs)
#   public/en/      → English
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
quarto="${QUARTO:-quarto}"
cd "$root"

# Versi dari VERSION → books/*/_variables.yml. Wajib di sini, bukan hanya di ./task, karena
# deploy VPS memanggil skrip ini langsung.
sh tools/gen-version.sh

rm -rf public

sh tools/sync-assets.sh

"$quarto" render books/id
"$quarto" render books/en

[ -f books/id/_book/index.html ] || { echo "render Indonesia gagal"; exit 1; }
[ -f books/en/_book/index.html ] || { echo "render English gagal"; exit 1; }

mkdir -p public/en
cp -a books/id/_book/. public/
cp -a books/en/_book/. public/en/

# Cache busting: nama berkas CSS tetap (Quarto tidak memberi hash), sedangkan Cloudflare
# menyimpan aset berhari-hari. Sematkan versi di URL supaya rilis baru tidak memakai CSS lama.
versi="$(tr -d '[:space:]' < VERSION)"
find public -name '*.html' -exec perl -pi -e "s|assets/ku\.css|assets/ku.css?v=${versi}|g; s|\.pdf\"|.pdf?v=${versi}\"|g" {} +

printf 'public/: %s berkas\n' "$(find public -type f | wc -l | tr -d ' ')"
find public -name '*.pdf' | sed 's|^|  |'
