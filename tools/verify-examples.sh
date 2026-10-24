#!/usr/bin/env bash
# Verifikasi semua contoh: kompilasi, jalankan, bandingkan keluarannya.
#
# Konvensi nama berkas (dipaksa oleh Nim: nama modul harus identifier valid):
#   aNN_nama.nim
#   - .expected          stdout harus sama persis
#   - .expected-error     kompilasi harus GAGAL dan stderr memuat teks ini
#   - .mode               opsional, isinya:
#                           js            → `nim js`, lalu dijalankan dengan node
#                           <flag nim>    → argumen tambahan untuk `nim c -r`, mis. --mm:arc
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
nim_bin="${NIM:-nim}"
out="$root/build/verify"
cache="$root/build/nimcache"
mkdir -p "$out" "$cache"

# Contoh files-and-os membaca variabel ini; keluaran harus tidak bergantung environment pemanggil.
unset NIM_ID_GREETING || true

lulus=0
gagal=0
daftar_gagal=()

catat_gagal() {
  gagal=$((gagal + 1))
  daftar_gagal+=("$1")
}

catat_lulus() {
  lulus=$((lulus + 1))
}

# Bandingkan stdout terhadap .expected.
cek_keluaran() {
  local src=$1 stdout_file=$2
  local harap="${src%.nim}.expected"
  if [ ! -f "$harap" ]; then
    catat_gagal "$3: kompilasi sukses tapi tidak ada ${harap#"$root"/}"
    return
  fi
  if diff -u "$harap" "$stdout_file" >"$out/$(basename "${src%.nim}").diff"; then
    catat_lulus
  else
    catat_gagal "$3: stdout berbeda (build/verify/$(basename "${src%.nim}").diff)"
  fi
}

# Pastikan stderr memuat isi .expected-error.
cek_error() {
  local src=$1 stderr_file=$2
  local harap="${src%.nim}.expected-error"
  if [ ! -f "$harap" ]; then
    catat_gagal "$3: gagal dikompilasi tanpa ${harap#"$root"/}"
    # Tampilkan sebabnya: tanpa ini kegagalan hanya terbaca sebagai "gagal".
    sed -n '1,3p' "$stderr_file" | sed 's/^/      /' >&2
  # `grep -F` treats every line of a multi-line pattern as a separate alternative, so a
  # two-line expectation would pass on either line alone. Compare the whole text instead.
  elif python3 -c 'import sys; h = open(sys.argv[1]).read().strip(); e = open(sys.argv[2]).read(); sys.exit(0 if h and h in e else 1)' "$harap" "$stderr_file"; then
    catat_lulus
  else
    catat_gagal "$3: pesan error tidak memuat isi ${harap#"$root"/}"
  fi
}

shopt -s nullglob
for dir in "$root"/examples/*/; do
  for src in "$dir"*.nim; do
    nama="$(basename "$src" .nim)"
    # Hanya berkas contoh: aNN_* atau nama yang memang diawali angka. Berkas pendukung
    # (store.nim, helper.nim) dilewati; ia ikut terverifikasi lewat pemakainya.
    case "$nama" in
      a[0-9][0-9]_* | [0-9]*) ;;
      *) continue ;;
    esac
    rel="${src#"$root"/}"
    stdout_file="$out/$nama.out"
    stderr_file="$out/$nama.err"
    biner="$out/$nama"

    mode=""
    mode_file="${src%.nim}.mode"
    if [ -f "$mode_file" ]; then
      mode="$(tr -d '\n' < "$mode_file" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    fi

    if [ "$mode" = "js" ]; then
      js_file="$out/$nama.js"
      if "$nim_bin" js --hints:off --out:"$js_file" --nimcache:"$cache" "$src" \
          >"$stdout_file" 2>"$stderr_file"; then
        if ! command -v node >/dev/null 2>&1; then
          catat_gagal "$rel: butuh node untuk menjalankan hasil nim js"
        elif node "$js_file" >"$stdout_file" 2>>"$stderr_file"; then
          cek_keluaran "$src" "$stdout_file" "$rel"
        else
          catat_gagal "$rel: node keluar bukan nol (build/verify/$nama.err)"
        fi
      else
        cek_error "$src" "$stderr_file" "$rel"
      fi
      continue
    fi

    # shellcheck disable=SC2086
    if "$nim_bin" c -r --hints:off $mode --out:"$biner" --nimcache:"$cache" "$src" \
        >"$stdout_file" 2>"$stderr_file"; then
      cek_keluaran "$src" "$stdout_file" "$rel"
    else
      cek_error "$src" "$stderr_file" "$rel"
    fi
  done
done

printf '\n%d lulus, %d gagal\n' "$lulus" "$gagal"
if [ "$gagal" -ne 0 ]; then
  printf '  %s\n' "${daftar_gagal[@]}"
  exit 1
fi
