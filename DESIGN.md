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
- Ukuran badan 18px di layar, 10pt di PDF, tinggi baris 1.65.
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

- Trim 178 × 233 mm, margin 16 × 18 mm (sudah terpasang lewat `assets/typst/typst-show.typ`).
- Badan 10pt, rata kiri (tidak justify, karena justify pada kolom sempit menghasilkan sungai
  spasi), jarak antarparagraf 1.3em, tanpa indentasi baris pertama. Diterapkan di
  `assets/typst/typst-show.typ` lewat `#show par: set par(justify: false, spacing: 1.3em)`.
- Pembuka bab: nomor bab besar, judul, garis horizontal tipis di bawahnya.
- Blok kode: latar abu hangat, ukuran 8.5pt, tidak pernah terpotong ke halaman berikutnya tanpa
  pemisah.
- Running head: judul buku di halaman kiri, judul bab di halaman kanan. Nomor halaman di bawah.
- Tanpa warna aksen di badan teks; aksen hanya untuk garis judul bab dan tautan.

## Batasan teknis

- Tanpa framework CSS tambahan, tanpa webfont dari CDN.
- Satu berkas CSS bersama: `assets/ku.css`, disalin ke tiap buku saat build.
- Semua perubahan harus lolos `./task check` dan diperiksa di dua bahasa (paritas ID/EN tidak
  boleh rusak).
