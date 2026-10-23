# Dasar Pemrograman Nim

[![ci](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml/badge.svg)](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml)
[![versi](https://img.shields.io/github/v/tag/nferdazel/nim-id?label=versi&color=1f3a5f)](https://github.com/nferdazel/nim-id/tags)
[![lisensi teks](https://img.shields.io/badge/teks-CC%20BY--SA%204.0-1f3a5f)](LICENSE)
[![lisensi kode](https://img.shields.io/badge/kode-MIT-1f3a5f)](LICENSE-CODE)
![Nim](https://img.shields.io/badge/Nim-2.2.12-1f3a5f)
![Quarto](https://img.shields.io/badge/Quarto-1.10-1f3a5f)

Buku belajar bahasa [Nim](https://nim-lang.org) untuk pembaca yang sudah pernah menulis program di
bahasa lain, tapi belum pernah menyentuh bahasa yang dikompilasi ke native.

- **Indonesia:** [nim.qouver.com](https://nim.qouver.com)
- **English:** [nim.qouver.com/en](https://nim.qouver.com/en)
- **PDF Indonesia:** [Dasar-Pemrograman-Nim.pdf](https://nim.qouver.com/Dasar-Pemrograman-Nim.pdf)
- **PDF English:** [Learning-Nim.pdf](https://nim.qouver.com/en/Learning-Nim.pdf)

Satu sumber Markdown menghasilkan web dan PDF. Setiap contoh di `examples/` dikompilasi, dijalankan,
dan keluarannya dibandingkan otomatis; satu set contoh dipakai kedua bahasa, jadi snippet yang basi
membuat build gagal, bukan lolos diam-diam.

## Isi buku

**Bagian 0, mulai:** apa itu Nim dan kenapa, instalasi, alur kerja `nim r`, komentar dan doc
comment.

**Bagian A, dasar:** variabel, tipe primitif dan literal, string, `echo` dan format, operator,
percabangan, perulangan, `array`/`seq`/`openArray`, prosedur, tuple, object, enum dan set.

Jawaban latihan ada di lampiran, di halaman yang sama untuk kedua bahasa.

## Menjalankan

Butuh [Nim](https://nim-lang.org/install.html) 2.2.12 dan [Quarto](https://quarto.org) 1.10.x.

| Perintah | Hasil |
|---|---|
| `./task contoh` | kompilasi dan verifikasi semua contoh |
| `./task site` | render Indonesia + English, hasil di `public/` |
| `./task id` / `./task en` | render satu bahasa saja |
| `./task pdf` | PDF kedua bahasa |
| `./task dev` | preview lokal dengan auto-reload |
| `./task check` | gerbang lengkap sebelum commit |
| `./task versi` | cetak nomor versi buku |
| `./task rilis` | naikkan versi dari pesan commit, lalu commit + tag |

Kalau Quarto tidak ada di `PATH`:

```sh
QUARTO=$HOME/.local/opt/bin/quarto ./task site
```

`task` adalah skrip POSIX, bukan Taskfile atau just: perintah yang sama dipakai di laptop dan CI,
tanpa tooling tambahan.

## Struktur

```
books/
  id/                  project Quarto Indonesia (akar situs)
  en/                  project Quarto English (/en/), nama berkas sama
    _quarto.yml        daftar bab dan format
    index.qmd          halaman depan
    copyright.qmd      hak cipta dan lisensi
    chapters/*.qmd     16 bab, nama berkas bahasa Inggris
    appendix/answers.qmd
examples/
  variables/           satu folder per bab, dipakai kedua bahasa
    a01_declaration.nim
    a01_declaration.expected             stdout yang diharapkan
    a03_immutable_error.expected-error   error kompilasi yang diharapkan
assets/                CSS dan partial typst bersama (disalin saat build)
tools/                 verify-examples, build-site, sync-assets, gen-version, rilis
ops/                   blok Caddy, setup VPS, deploy static
docs/                  rencana, pedoman penulisan, glosarium, rilis
```

Nama berkas dan folder berbahasa Inggris. Nama berkas contoh **wajib** `aNN_nama.nim`: Nim menolak
nama modul yang diawali angka atau memakai tanda hubung.

## Menambah bab

1. Tulis `books/id/chapters/<name>.qmd` dan `books/en/chapters/<name>.qmd` dengan nama berkas sama.
2. Daftarkan di `books/id/_quarto.yml` dan `books/en/_quarto.yml`.
3. Taruh snippet di `examples/<name>/`, lengkap dengan `.expected` atau `.expected-error`.
4. Ikuti [pedoman penulisan](docs/writing-guide.md); istilah baru masuk
   [glosarium](docs/glossary.md) dulu.
5. `./task check` harus hijau sebelum commit.

## Rilis

Nomor versi ada di `VERSION` dan naik otomatis dari pesan commit lewat `./task rilis`. Tag `vX.Y.Z`
tidak memicu CI ulang dan tidak memicu deploy, karena commit yang sama sudah lolos di `main`.
Aturan lengkapnya di [docs/release.md](docs/release.md).

## Lisensi

- **Teks buku** (`books/`, `docs/`): CC BY-SA 4.0, lihat [LICENSE](LICENSE).
- **Kode contoh** (`examples/`, `tools/`, potongan kode di dalam buku): MIT, lihat
  [LICENSE-CODE](LICENSE-CODE).

Kalau mengutip buku, sebutkan sumber dan tautan ke `nim.qouver.com`. Cara berkontribusi ada di
[CONTRIBUTING.md](CONTRIBUTING.md).
