#!/usr/bin/env bash
# Verifikasi semua contoh: kompilasi, jalankan, bandingkan keluarannya.
#
# Konvensi nama berkas (dipaksa oleh Nim: nama modul harus identifier valid):
#   aNN_nama.nim
#   - .expected          stdout harus sama persis
#   - .expected-error     kompilasi harus GAGAL dan stderr memuat teks ini
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
nim_bin="${NIM:-nim}"
out="$root/build/verify"
cache="$root/build/nimcache"
mkdir -p "$out" "$cache"

lulus=0
gagal=0
daftar_gagal=()

shopt -s nullglob
for dir in "$root"/examples/*/; do
  for src in "$dir"*.nim; do
    nama="$(basename "$src" .nim)"
    rel="${src#"$root"/}"
    stdout_file="$out/$nama.out"
    stderr_file="$out/$nama.err"
    biner="$out/$nama"

    if "$nim_bin" c -r --hints:off --out:"$biner" --nimcache:"$cache" "$src" \
        >"$stdout_file" 2>"$stderr_file"; then
      harap="${src%.nim}.expected"
      if [ ! -f "$harap" ]; then
        gagal=$((gagal + 1))
        daftar_gagal+=("$rel: kompilasi sukses tapi tidak ada ${harap#"$root"/}")
      elif diff -u "$harap" "$stdout_file" >"$out/$nama.diff"; then
        lulus=$((lulus + 1))
      else
        gagal=$((gagal + 1))
        daftar_gagal+=("$rel: stdout berbeda (build/verify/$nama.diff)")
      fi
    else
      harap="${src%.nim}.expected-error"
      if [ ! -f "$harap" ]; then
        gagal=$((gagal + 1))
        daftar_gagal+=("$rel: gagal dikompilasi tanpa ${harap#"$root"/}")
      elif grep -qF -- "$(cat "$harap")" "$stderr_file"; then
        lulus=$((lulus + 1))
      else
        gagal=$((gagal + 1))
        daftar_gagal+=("$rel: pesan error tidak memuat isi ${harap#"$root"/}")
      fi
    fi
  done
done

printf '\n%d lulus, %d gagal\n' "$lulus" "$gagal"
if [ "$gagal" -ne 0 ]; then
  printf '  %s\n' "${daftar_gagal[@]}"
  exit 1
fi
