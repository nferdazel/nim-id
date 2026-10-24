# DESIGN.md

Arah visual buku **Dasar Pemrograman Nim / Learning Nim**. Dokumen ini yang dipakai sebagai acuan
saat mengubah CSS web dan template PDF. Kalau sebuah keputusan visual tidak bisa dijelaskan lewat
berkas ini, keputusan itu belum layak masuk.

## Identitas

Buku teknis yang diterbitkan sendiri, dua bahasa, untuk pembaca yang sudah bisa menulis program di
bahasa lain. Bukan landing page produk, bukan dokumentasi API. Yang dijual adalah **keterbacaan
jangka panjang**: orang membaca bab ini 40 menit, bukan 40 detik.

- **Audiens:** developer yang pindah ke Nim, membaca di laptop dan di kertas cetak.
- **Kepribadian:** tenang, presisi, tanpa basa-basi pemasaran. Seperti buku ajar universitas yang
  dirawat baik, bukan majalah teknologi.
- **Yang dihindari:** gradien, kaca/blur, bayangan mengambang, sudut pil, badge dekoratif, emoji.

## Dial

```
ENERGY 1 / RHYTHM 2 / MOTION 1
```

- **ENERGY 1:** halaman tidak "menyapa" dengan keras. Tidak ada hero besar, tidak ada CTA.
- **RHYTHM 2:** sebagian besar konsisten (sidebar, kepala bab, blok kode), dengan beberapa
  pemecah ritme: pembuka bab, kotak catatan, tabel.
- **MOTION 1:** hanya state hover dan fokus. Tidak ada animasi masuk, tidak ada parallax, tidak
  ada loop.

## Palet

Dua warna inti + satu aksen. Netral tidak dihitung.

| Peran | Nilai | Alasan |
|---|---|---|
| Kertas | `#FCFBF7` | Putih hangat, meniru kertas buku; mengurangi silau dibanding putih murni |
| Tinta | `#1A1C1F` | Hampir hitam, kontras 16:1 di atas kertas |
| Tinta lembut | `#4A4E55` | Teks sekunder, metadata; tetap di atas 4.5:1 |
| Aksen | `#1F3A5F` | Navy tinta, dipakai untuk tautan dan penanda bab. Bukan biru terang aplikasi |
| Garis | `#DDD8CC` | Garis tipis pemisah; tidak pernah jadi blok warna |
| Kode | `#F4F1EA` | Latar blok kode, satu tingkat lebih gelap dari kertas |

Aksen hanya untuk: tautan, nomor bab, dan satu garis pembuka bab. Tidak dipakai untuk tombol,
badge, atau latar section.

## Tipografi

| Peran | Keluarga | Alasan |
|---|---|---|
| Badan teks | `"Iowan Old Style", "Palatino Linotype", Palatino, Georgia, serif` | Serif untuk bacaan panjang; tidak butuh unduhan font, sudah ada di macOS/Windows |
| Judul | sama dengan badan teks, bobot 600 | Buku, bukan dashboard: judul tidak perlu sans terpisah |
| Kode | `ui-monospace, SFMono-Regular, Menlo, Consolas, monospace` | Monospace sistem, tanpa webfont |
| Metadata/UI kecil | `system-ui, "Segoe UI", sans-serif` | Hanya untuk label kecil (sidebar, footer, badge versi) |

Aturan:

- Lebar baca maksimum **68 karakter** (`~34rem` pada 18px). Tidak ada paragraf selebar layar.
- Ukuran badan 18px di layar, 11pt di PDF, tinggi baris 1.65.
- Judul bab memakai ukuran besar tapi tidak ekstrem: 2rem di layar.
- Huruf miring untuk istilah asing, konsisten dengan `docs/glossary.md`.
- Tidak ada uppercase dengan letter-spacing lebar kecuali label kecil di sidebar.

## Web

- Sidebar kiri, latar kertas, tanpa bayangan, garis kanan 1px.
- Blok kode: latar `#F4F1EA`, tanpa sudut membulat besar (2px), tanpa bayangan, padding lega.
- Blok keluaran (`.txt`): sama seperti kode, dengan label kecil "output" dan garis kiri 2px aksen
  lembut supaya bisa dibedakan tanpa warna mencolok.
- Tabel: garis horizontal tipis saja, tanpa zebra, selaras kiri.
- Callout: garis kiri 2px aksen, latar transparan, tanpa ikon dekoratif.
- Tautan: aksen navy, garis bawah tipis yang menebal saat hover.
- Dark mode tidak disediakan: buku ini print-first, dan tema gelap akan memutus hubungan visual
  dengan PDF. Alasan ini yang dipakai, bukan "belum sempat".
- Responsif: satu kolom di bawah 768px, sidebar jadi daftar bab yang bisa dibuka, blok kode
  menggulung horizontal, tap target minimal 44px.

## PDF

- Trim 178 × 233 mm, margin kiri dan kanan sama 29,5 mm, atas 21 mm, bawah 25 mm (terpasang lewat
  `assets/typst/typst-show.typ`). Tidak ada margin cermin: buku ini digital-only, dan margin
  bercermin membuat kolom teks bergeser 5 mm antara halaman ganjil dan genap, yang terbaca sebagai
  indentasi tidak seragam saat halaman dibalik. Lebar kolom tetap 119 mm, jadi tidak ada reflow.
- Badan 11pt, rata kiri (tidak justify, karena justify pada kolom sempit menghasilkan sungai
  spasi), jarak antarparagraf 1.3em, tanpa indentasi baris pertama. Ukurannya datang dari
  `font-size: 11pt` di konfigurasi orange-book dan menghasilkan 68 karakter per baris pada kolom
  119 mm, sama dengan batas baca 68 karakter di web. Diterapkan di
  `assets/typst/typst-show.typ` lewat `#show par: set par(justify: false, spacing: 1.3em)`.
  Pemecah barisnya `linebreaks: "optimized"`, bukan greedy bawaan Typst: diukur pada 0.7.3,
  widow turun dari 9 ke 1 (ID) dan 8 ke 0 (EN), jumlah halaman dan potongan panel tidak berubah.
  Typst tidak punya pola pemenggalan untuk `id` (0 soft hyphen di 408 halaman, versus 9 di EN),
  jadi tepi kanan yang tidak rata sepenuhnya ditangani pemecah ini. Konsekuensinya: edisi ID tidak
  boleh dipindah ke `justify: true`, karena tanpa pola `id` hasilnya sungai spasi.
- Pembuka bab: nomor bab besar, judul, garis horizontal tipis di bawahnya.
- Blok kode: latar abu hangat, ukuran 9pt (`#let code-size`), tidak pernah terpotong ke halaman
  berikutnya tanpa pemisah.
- Running head: judul buku di halaman kiri, judul bab di halaman kanan. Nomor halaman di bawah.
- Tanpa warna aksen di badan teks; aksen hanya untuk garis judul bab dan tautan.

## Batasan teknis

- Tanpa framework CSS tambahan, tanpa webfont dari CDN.
- Satu berkas CSS bersama: `assets/ku.css`, disalin ke tiap buku saat build.
- Semua perubahan harus lolos `./task check` dan diperiksa di dua bahasa (paritas ID/EN tidak
  boleh rusak).

## Sistem visual (revisi 2)

Versi pertama terlalu datar: hasilnya masih terbaca sebagai "situs contoh Quarto". Revisi ini
menaikkan ENERGY ke 2 dengan mengandalkan tipografi dan aturan garis, bukan warna atau dekorasi.

```
ENERGY 2 / RHYTHM 2 / MOTION 1
```

### Halaman depan (pembuka buku)

- Blok pembuka selebar kolom baca, bukan hero selebar layar.
- Judul buku 3rem serif, diikuti garis ganda tipis (2px navy + 1px garis) selebar 6rem.
- Subjudul miring, satu baris.
- Baris metadata kecil: penulis, versi, tanggal, ukuran PDF, dipisah titik tengah.
- Di kanan blok pembuka, satu tautan tegas: "Unduh PDF" dengan garis bawah, bukan tombol.
- Tidak ada gambar sampul, tidak ada logo. Identitas dibawa oleh tipografi dan garis.

### Pembuka bab

- Nomor bab 4rem, tabular, navy, diletakkan di atas judul, rata kiri.
- Judul bab 2rem, garis bawah 1px selebar kolom.
- Paragraf pertama sedikit lebih besar (1.05em) sebagai "lead".

### Sidebar dan bagian buku

- Sidebar memakai `book: parts`: "Bagian A: Dasar", "Bagian B: Menengah", "Bagian C: Praktik", dan
  lampiran A sampai D.
- Label bagian kecil, uppercase, letter-spacing 0.08em, dengan garis atas tipis.
- Bab aktif: garis navy 2px di kiri, teks tinta, tanpa latar.
- Nomor bab di sidebar tabular, lebar tetap, rata kanan supaya judul sejajar.
- Kotak pencarian: hanya garis bawah, bukan kotak berbingkai.
- Catatan penyimpangan: `book: parts` dipakai bersama format typst, jadi PDF ikut
  mendapat halaman judul bagian (114 → 118 halaman). Itu konsekuensi langsung dari
  struktur parts yang diminta, bukan perubahan pada `assets/typst/**`.

### Blok kode dan keluaran

- Setiap blok kode punya pita atas tipis: label bahasa (`nim`) di kiri, tombol salin di kanan.
- Blok keluaran memakai pita yang sama dengan label `output`, garis kiri 2px navy.
- Latar kode satu tingkat di atas kertas; tanpa bayangan, radius maksimum 2px.
- Baris kode minimal 1.5 tinggi; padding 0.9rem 1rem.

### Navigasi bawah

- Dua kolom: "Sebelumnya" dan "Berikutnya", label kecil uppercase, judul bab serif.
- Tanpa panah dekoratif, tanpa tombol berwarna.

### Yang tetap dilarang

Gradien, kaca/blur, bayangan mengambang, sudut pil, badge dekoratif, ikon dekoratif, emoji,
animasi masuk, parallax, dark mode (alasan print-first di bagian atas).

### Verifikasi wajib

- Screenshot 1440px untuk halaman depan, satu bab, dan lampiran.
- Screenshot 390px lewat iframe (Chrome headless macOS minimum 500px, jadi iframe 390px).
- Tidak ada overflow horizontal, tidak ada teks terpotong.
- Kontras semua pasangan teks/latar minimal 4.5:1.
