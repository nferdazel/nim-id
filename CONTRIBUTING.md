# Berkontribusi

Buku ini tumbuh dari koreksi pembaca. Yang paling berguna justru laporan kecil: contoh yang tidak
jalan, istilah yang membingungkan, atau kalimat yang salah eja.

## Yang bisa dikirim

| Jenis | Cara |
|---|---|
| Contoh gagal di versi Nim terbaru | buka issue, sertakan versi Nim dan keluaran `nim r` |
| Salah ketik, kalimat rancu, istilah tidak konsisten | pull request kecil, satu berkas satu PR |
| Usul bab baru | issue dulu, supaya tidak dua orang menulis bab yang sama |
| Terjemahan | issue dulu; bahasa ketiga butuh keputusan struktur, bukan sekadar menerjemahkan |

## Sebelum mengirim

```sh
QUARTO=$HOME/.local/opt/bin/quarto ./task check
```

Perintah itu mengompilasi semua contoh di `examples/`, membandingkan keluarannya, lalu merender
kedua buku. Kalau merah, perbaiki dulu. CI menjalankan pemeriksaan yang sama.

## Menulis bab

1. Baca [`docs/writing-guide.md`](docs/writing-guide.md): template bab, aturan kalimat, dan
   Definition of Done.
2. Istilah baru masuk [`docs/glossary.md`](docs/glossary.md) dulu, baru dipakai.
3. Setiap blok `{.nim}` di bab harus punya pasangan di `examples/<bab>/aNN_nama.nim`, lengkap
   dengan `.expected` atau `.expected-error`. Konvensinya di `tools/verify-examples.sh`.
4. Tulis versi Indonesia di `books/id/chapters/` dan English di `books/en/chapters/` dengan nama
   berkas yang sama, struktur yang sama, dan blok kode yang identik.
5. Kode selalu bahasa Inggris: identifier, komentar, dan teks di dalam string.

## Gaya commit

Pesan commit memakai awalan Conventional Commits, karena `./task release` membacanya untuk menentukan
naik versi:

```
feat: bab modules
fix: contoh loops salah keluaran di Nim 2.2.12
docs: perjelas bagian closure
chore: rapikan skrip build
```

`feat!:` atau baris `BREAKING CHANGE:` menandai perubahan besar. Aturan lengkapnya di
[`docs/release.md`](docs/release.md).

## Cabang dan pull request

Jangan push langsung ke `main`; push ke `main` langsung terbit ke produksi lewat webhook deploy.
Buat cabang, kirim pull request, tunggu CI hijau.

## Lisensi kontribusi

Dengan mengirim kontribusi, kamu setuju kontribusimu dilisensikan dengan lisensi yang sama:
teks buku CC BY-SA 4.0 ([`LICENSE`](LICENSE)), kode contoh MIT ([`LICENSE-CODE`](LICENSE-CODE)).
Jangan mengirim teks atau kode yang hak ciptanya bukan milikmu.
