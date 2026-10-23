# nim-id

[![ci](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml/badge.svg)](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml)

Buku belajar bahasa [Nim](https://nim-lang.org) dalam dua bahasa: Indonesia dan Inggris.
Situs: `nim.qouver.com` (`/en/` untuk versi Inggris).

Setiap contoh di `examples/` dikompilasi dan keluarannya dibandingkan otomatis. Satu set contoh
dipakai kedua bahasa, jadi snippet tidak bisa "basi" tanpa membuat build gagal.

## Menjalankan

Butuh [Nim](https://nim-lang.org/install.html) 2.2.12 dan [Quarto](https://quarto.org) 1.10.x.

```sh
./task contoh    # kompilasi + verifikasi semua contoh
./task site      # render id + en, hasil di public/
./task id        # hanya versi Indonesia
./task en        # hanya versi English
./task pdf       # PDF kedua bahasa
./task dev       # preview lokal
./task check     # contoh + site (gate sebelum commit)
./task versi     # cetak nomor versi buku
./task rilis     # naikkan versi dari commit, lalu commit + tag
```

Versi buku ada di `VERSION` (semver, tag `vX.Y.Z`), naik otomatis lewat `./task rilis`; aturannya di
[docs/release.md](docs/release.md).

`task` adalah skrip POSIX, bukan Taskfile/just. Kalau Quarto tidak ada di `PATH`:
`QUARTO=$HOME/.local/opt/bin/quarto ./task site`.

## Struktur

```
books/
  id/                     # project Quarto Indonesia (akar situs)
    _quarto.yml
    index.qmd
    chapters/*.qmd        # 16 bab, nama berkas bahasa Inggris
    appendix/answers.qmd
  en/                     # project Quarto English (/en/), nama berkas sama
    _quarto.yml
    index.qmd
    chapters/*.qmd        # 16 bab, nama berkas bahasa Inggris
    appendix/answers.qmd
examples/
  variables/              # satu folder per bab, dipakai kedua bahasa
    a01_declaration.nim
    a01_declaration.expected            stdout yang diharapkan
    a03_immutable_error.expected-error  pesan error yang diharapkan
assets/                   # CSS bersama (disalin ke tiap buku saat build)
tools/                    # verify-examples.sh, build-site.sh
ops/                      # blok Caddy, setup & deploy static
docs/                     # plan, pedoman penulisan, glosarium, catatan deploy
```

Nama berkas dan folder berbahasa Inggris. Nama berkas contoh **wajib** `aNN_nama.nim`: Nim menolak
nama modul yang dimulai angka atau memakai tanda hubung.

## Menambah bab

1. Tulis versi Indonesia `books/id/chapters/<name>.qmd` dan Inggris
   `books/en/chapters/<name>.qmd` dengan nama berkas **sama**.
2. Daftarkan di `books/id/_quarto.yml` **dan** `books/en/_quarto.yml`.
3. Taruh snippet di `examples/<chapter>/`, lengkap dengan `.expected` atau `.expected-error`.
4. Ikuti [`docs/writing-guide.md`](docs/writing-guide.md). Istilah baru masuk
   [`docs/glossary.md`](docs/glossary.md) dulu.
5. `./task check` harus hijau sebelum commit.

## Lisensi

Dua lisensi, sesuai isinya:

- **Teks buku** (`books/`, `docs/`): CC BY-SA 4.0, lihat [LICENSE](LICENSE).
- **Kode contoh** (`examples/`, `tools/`, potongan kode di dalam buku): MIT, lihat
  [LICENSE-CODE](LICENSE-CODE).

Kalau mengutip buku, sebutkan sumber dan tautan ke `nim.qouver.com`.
