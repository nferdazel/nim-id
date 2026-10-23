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

printf 'public/: %s berkas\n' "$(find public -type f | wc -l | tr -d ' ')"
find public -name '*.pdf' | sed 's|^|  |'
