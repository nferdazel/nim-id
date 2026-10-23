# Pedoman Penulisan

Dokumen ini mengikat. Kalau ada yang tidak diatur di sini, tanya dulu sebelum menulis.

## Pembaca

Sudah pernah menulis program di bahasa lain (variabel, perulangan, fungsi), belum pernah memakai
Nim. Jangan menjelaskan apa itu variabel. Jelaskan apa yang **berbeda** di Nim.

## Suara

- Imperatif untuk instruksi: "Simpan sebagai `coba.nim`", "Hapus baris 4".
- "Kita" untuk langkah bersama: "Sekarang kita tambahkan parameter kedua."
- "Pembaca" saat membahas kesalahpahaman: "Di titik ini pembaca sering mengira `let` sama
  dengan `const`."
- Jangan campur dengan "Anda", "lu", "gue". Tanpa emoji.

## Dua bahasa

- Setiap bab ada dua: `books/id/chapters/<name>.qmd` dan `books/en/chapters/<name>.qmd`,
  **nama berkas sama persis**. Nama bab di `books/id/_quarto.yml` dan `books/en/_quarto.yml` harus sepadan.
- Terjemahan bukan kata-per-kata. Idiom, contoh, dan sapaan disesuaikan; yang wajib sama adalah
  urutan bagian, kode, dan keluaran.
- **Kode selalu bahasa Inggris**: identifier, komentar, dan string. Prosa yang menjelaskan.
  Alasannya: satu set `examples/` dipakai kedua buku, dan satu verifikasi berlaku untuk keduanya.
- Blok `output` **identik** di kedua bahasa karena kodenya sama. Jangan diterjemahkan.
- Istilah mengikuti [`glossary.md`](glossary.md), yang memetakan istilah Indonesia ke bahasa Inggris.
- Commit yang hanya menyentuh satu bahasa harus menyebut apakah sisi lain perlu disusul.

## Kalimat

- Rata-rata ≤ 20 kata. Satu ide per paragraf, ≤ 4 baris.
- Kalimat aktif. "Compiler menolak baris ini karena X", bukan "baris ini ditolak oleh compiler
  dikarenakan X".
- Buang: "pada era digital ini", "seperti yang kita ketahui", "tentu saja", "perlu diingat
  bahwa", "pada kesempatan kali ini".
- Frasa favorit maksimal 1× per bab: "kurang lebih seperti berikut", "sebagai berikut", "oke".
- Setiap klaim teknis bisa diuji. Sebut versi: "diuji di Nim 2.2.12".

Contoh:

> ❌ "Pada kesempatan kali ini, kita akan membahas mengenai konsep variabel yang mana merupakan
> salah satu konsep fundamental dalam bahasa pemrograman Nim."
>
> ✅ "Variabel adalah nama untuk sebuah nilai. Di Nim, variabel dideklarasikan dengan `var`."

## Istilah

- Ejaan mengikuti EYD V. Istilah asing yang belum ada padanan dicetak *miring*.
- Penulisan istilah yang dipakai dan yang dilarang ada di [`glossary.md`](glossary.md).
  Tambahkan istilah baru di sana **sebelum** dipakai di bab.

## Bentuk bab

1. **Hook** 2–4 kalimat: masalah nyata atau miskonsepsi yang dibongkar. Bukan "Bab ini akan
   membahas…".
2. **Tujuan** dalam callout: "Setelah bab ini, pembaca bisa …".
3. **Konsep** sesingkat mungkin, satu contoh kecil yang jalan.
4. **Bangun bertahap**: satu program yang tumbuh; satu langkah = satu perubahan + satu output.
5. **Error-first**: sengaja salahkan kode, tampilkan pesan compiler asli, ajari cara membaca
   pesan itu (berkas, baris/kolom, tingkat, isi).
6. **Output nyata** di blok ```` ```{.txt} ````, bukan gambar.
7. **Latihan 3–5 soal** bergradasi: ubah, prediksi output, tulis dari nol, perbaiki kode rusak.
   Jawaban di `books/id/appendix/answers.qmd` dan `books/en/appendix/answers.qmd`, bukan di bawah soal.
8. **Ringkasan** 3–5 poin.
9. **Selanjutnya** satu tautan ke bab berikutnya.

Panjang: 900–1.400 kata. Satu bab = satu sesi baca 10–15 menit. Lebih dari itu, pecah.

## Kode

- Setiap snippet di bab **wajib** ada di `examples/<kode-bab>-<nama>/aNN_nama.nim`, dengan
  `.expected` (stdout yang diharapkan) atau `.expected-error` (teks yang harus muncul di stderr
  saat kompilasi gagal).
- Nama berkas hanya huruf, angka, dan garis bawah; Nim menolak nama modul lain.
- Kode di bab harus **identik** dengan berkas contoh. Kalau butuh versi yang sengaja salah,
  jadikan berkas tersendiri berakhiran `.expected-error`.
- Output di bab disalin dari `.expected`, jangan diketik ulang dari ingatan.
- Contoh yang memerlukan berkas eksternal ditaruh di folder yang sama dan dibersihkan setelah
  jalan.

## Bahasa visual

- Kode dan output dibedakan: kode berlatar putih, output berlatar abu tipis dengan label
  `output` (lihat `assets/ku.css`).
- Tangkapan layar hanya kalau benar-benar visual (pesan compiler berwarna, TUI, grafik), maksimal
  satu per lima bab, selalu dengan alt text.
- Tabel maksimal 4 kolom; lebih dari itu pecah jadi dua tabel.

## PDF

- Ukuran trim 178 × 233 mm, margin 16 × 18 mm, diatur di `assets/typst/typst-show.typ`
  (partial Quarto, disalin ke tiap buku saat build).
- **Jangan** memakai `papersize` di `_quarto.yml`: template `orange-book` mengabaikannya dan
  memakai `paper-size`/`width`/`height`. Kalau trim berubah, ubah partial, bukan YAML.
- `format: typst: lang: <id|en>` wajib ada; tanpa itu label "Daftar Isi"/"Lampiran" jatuh ke
  bahasa Inggris.
- PDF dibuat dari sumber yang sama dengan web. Kalau PDF gagal, `./task site` gagal, bukan
  peringatan.

## Definition of Done

- [ ] Bisa dibaca mandiri tanpa bab sebelumnya.
- [ ] Semua snippet ada di `examples/` dan `./task examples` hijau.
- [ ] Minimal satu error sengaja, dengan cara membacanya.
- [ ] Latihan + jawaban di lampiran.
- [ ] Tidak ada istilah di luar glosarium tanpa definisi.
- [ ] Terbaca di layar 390 px tanpa scroll horizontal (kecuali blok kode).
- [ ] Cetak hitam-putih masih terbaca.
- [ ] `./task check` hijau.
