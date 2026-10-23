#!/usr/bin/env sh
# Salin versi dari VERSION ke _variables.yml tiap buku.
# Quarto membaca _variables.yml di akar project; bab memakai shortcode {{< var version >}}.
# Berkas hasil dibuat saat build dan tidak di-commit (lihat .gitignore).
set -eu

root="$(cd "$(dirname "$0")/.." && pwd)"
ver=$(tr -d '[:space:]' < "$root/VERSION")

case "$ver" in
  '' | *[!0-9.]* | .* | *. | *..*)
    echo "VERSION tidak valid: '$ver' (harus seperti 0.1.0)" >&2
    exit 1
    ;;
esac

for b in id en; do
  printf 'version: "%s"\n' "$ver" > "$root/books/$b/_variables.yml"
done
