# Rilis dan versi

Nomor versi tinggal di satu tempat: berkas `VERSION`. Buku membacanya lewat shortcode
`{{< var version >}}`; `tools/gen-version.sh` menyalin `VERSION` ke `books/*/_variables.yml`
saat build, dan berkas hasil itu tidak di-commit.

## Cara kerja X.Y.Z

Tiga angka, dibaca dari kiri: **X.Y.Z**. Naikkan **satu** angka, nolkan yang di kanannya.

| Angka | Nama | Naik kalau | Akibat ke pembaca |
|---|---|---|---|
| X | MAJOR | isi berubah sampai pembaca lama "salah jalan" | harus baca ulang dari awal |
| Y | MINOR | ada tambahan, yang lama tetap berlaku | aman, tinggal lanjut |
| Z | PATCH | hanya perbaikan | tidak ada yang perlu dilakukan |

Contoh nyata untuk buku ini:

| Kejadian | Versi | Alasan |
|---|---|---|
| `0.1.0` → `0.1.1` | PATCH | salah ketik, keluaran contoh berubah, tautan mati |
| `0.1.0` → `0.2.0` | MINOR | bab baru `modules` ditambahkan di akhir |
| `0.2.0` → `1.0.0` | MAJOR | urutan bab ditata ulang, `variables` dipecah dua |

Selama masih `0.x.y` ikuti aturan yang sama; `1.0.0` baru dipakai saat isi buku dianggap stabil
untuk pembaca pertama. `0.x` bukan alasan menaikkan angka sesuka hati.

## Otomatis: `./task rilis`

Skrip membaca commit sejak tag terakhir, menentukan tingkat naik, lalu membuat commit rilis dan
tag beranotasi.

```sh
./task rilis             # tingkat naik ditentukan otomatis
./task rilis --minor     # paksa MINOR (mis. bab baru tapi commit-nya lupa diawali feat:)
./task rilis --tanpa-cek # lewati ./task check (hanya kalau build baru saja dijalankan)
```

Pemetaan dari pesan commit (Conventional Commits):

| Awal pesan commit | Naik |
|---|---|
| `feat!: ...` atau ada baris `BREAKING CHANGE:` | MAJOR |
| `feat: ...` | MINOR |
| `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `style:`, `perf:`, tanpa awalan | PATCH |

Skrip berhenti kalau pohon kerja belum bersih, kalau tidak ada commit baru, atau kalau tag tujuan
sudah ada. Skrip **tidak** push; push tetap keputusan pemilik.

## Rilis pertama (sekali saja)

Belum ada tag, jadi tag pertama dibuat manual:

```sh
QUARTO=$HOME/.local/opt/bin/quarto ./task check
git add -A && git commit -m "feat: 16 bab M1"
git tag -a v0.1.0 -m "nim-id 0.1.0"
git push origin main --follow-tags
```

Sesudah `v0.1.0` ada, semua rilis berikutnya lewat `./task rilis`.

## Kenapa tag tidak memicu CI atau deploy

- CI hanya jalan untuk push ke `main` dan `workflow_dispatch`. Tag `v*` sengaja tidak memicu apa
  pun: commit yang sama sudah lolos di `main`, jadi menjalankan ulang hanya membakar menit.
- Deploy VPS dijaga ref-guard: hanya `refs/heads/main`. Push tag diabaikan, sesuai desain.
- Kalau nanti butuh artefak rilis, tambahkan job yang membaca `VERSION` sebagai nama berkas,
  jangan menghidupkan lagi trigger tag.
