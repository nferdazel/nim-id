#!/usr/bin/env sh
# Salin aset bersama ke tiap project Quarto.
#
# Quarto hanya menyalin berkas yang berada di dalam direktori project, jadi CSS dan partial typst
# disalin saat build. Berkas hasil tidak di-commit (lihat .gitignore).
set -eu

root="$(cd "$(dirname "$0")/.." && pwd)"

for b in id en; do
  mkdir -p "$root/books/$b/assets/typst"
  cp "$root/assets/ku.css" "$root/books/$b/assets/ku.css"
  cp "$root/assets/typst/typst-show.typ" "$root/books/$b/assets/typst/typst-show.typ"
  cp "$root/assets/skip-link-$b.html" "$root/books/$b/assets/skip-link.html"
done
