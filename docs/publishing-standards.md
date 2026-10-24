# Standar Penerbitan — Dasar Pemrograman Nim / Learning Nim

Dokumen ini adalah **ceklis yang bisa dieksekusi**, bukan esai. Setiap butir punya ID,
status (wajib / opsional / tidak lazim), ambang yang bisa diukur, dan cara memverifikasinya.
Dipakai untuk mengaudit PDF terbitan sendiri berukuran ~350–450 halaman.

- Berkas yang diatur: `books/{id,en}/**`, `assets/typst/typst-show.typ`, `books/*/_quarto.yml`.
- Keluaran yang dinilai: `public/Dasar-Pemrograman-Nim.pdf`, `public/en/Learning-Nim.pdf`.
- Arah visual: `DESIGN.md` (tipografi & palet). Dokumen ini mengatur **kerangka penerbitan**,
  bukan gaya visual; kalau keduanya bersinggungan, `DESIGN.md` menang untuk warna/jenis huruf.
- Naskah tidak boleh diubah lewat dokumen ini. Semua rekomendasi di §9 dipisahkan menurut
  pemilik wilayah: **template** (`assets/typst/**`, `_quarto.yml`), **naskah** (`books/**`),
  **keputusan pemilik**.

Rujukan praktik: O'Reilly (front/back matter ringkas, indeks ketat, kolofon di belakang),
Manning (indeks wajib untuk buku cetak, "About the author" di belakang), No Starch (front matter
geometris, lisensi jelas, bedah sinyal halaman), Pragmatic Bookshelf (terbit-sendiri, front matter
minimum, errata online), Addison-Wesley / Pearson (aturan orphan/widow ketat, penomoran
subbab bertingkat).

---

## 1. Materi depan (front matter)

Urutan standar. Kolom **status**: W = wajib, O = opsional, X = tidak lazim untuk terbit-sendiri.

| # | Halaman | Status | Catatan |
|---|---|---|---|
| F1 | **Half title** (judul saja) | X | Tanpa penerbit besar, halaman ini hanya memboroskan satu lembar. Boleh dilewati. |
| F2 | **Frontispiece** (gambar penuh) | X | Buku ini tanpa gambar; tidak relevan. |
| F3 | **Title page** | W | Judul, subjudul, penulis. Baris imprint (penerbit) hanya bila ada penerbit. |
| F4 | **Copyright / colophon page** | W | Wajib di **verso** (halaman kiri) tepat setelah title page. Lihat §3. |
| F5 | **Dedication** | O | Satu baris, tanpa judul. Boleh dilewati. |
| F6 | **Table of contents** | W | Wajib. Bila ada > 8 gambar/tabel bernomor, tambahkan list of figures/tables (untuk buku ini: tidak perlu, lihat N4). |
| F7 | **Preface / Prakata** | W untuk buku ini | Wajib bila buku punya klaim "untuk siapa" dan "cara membaca". |
| F8 | **Acknowledgements** | O | Boleh dilewati untuk penulis tunggal; bila ada kontributor/kredit pihak ketiga, **naik jadi W** (lihat §3 butir kredit). |
| F9 | **About this book / conventions** | O | Konvensi tipografi (huruf miring = istilah, `code` = sintaks). Buku ini menyebarkannya di Prakata; cukup. |
| F10 | **About the author** | O di depan / lihat B6 | Umumnya di materi belakang, bukan depan. |

**Penomoran Romawi.**
- Praktik klasik: materi depan memakai angka **romawi kecil** (`i, ii, iii, …`), huruf arab **mulai
  halaman pertama bab bernomor**.
- Halaman **judul dan copyright biasanya tidak difolio** (tersembunyi/`i`–`iv` dihitung, tidak dicetak).
- Alternatif modern yang lazim diterima untuk terbit-sendiri: materi depan **tanpa folio**
  (atau romawi) dan arab mulai dari bab pertama. Yang **tidak boleh**: folio materi depan memakai
  angka arab yang masuk ke urutan teks utama, sehingga daftar isi menunjuk dua sistem nomor
  bercampur.
- Syarat mutlak: **setiap nomor halaman di daftar isi cocok dengan folio yang tercetak** (F11).

| ID | Butir | Ambang |
|---|---|---|
| F11 | Folio di TOC = folio tercetak | 0 selisih pada setiap entri level 1 |
| F12 | Urutan TOC ↔ urutan fisik | TOC di depan konten yang dirujuk; copyright sebelum TOC |
| F13 | Title/copyright tanpa folio tercetak | 0 angka di dua halaman itu |
| F14 | Materi depan satu sistem nomor | romawi semua, atau tanpa folio semua — tidak campur arab+romawi |

---

## 2. Materi belakang (back matter)

| # | Halaman | Status | Catatan |
|---|---|---|---|
| B1 | **Appendices** (Lampiran) | W bila dirujuk naskah | Buku ini merujuk Lampiran A dari tiap bab → wajib. |
| B2 | **Glossary** | W untuk buku ini | 149 istilah sudah ada; letaknya setelah lampiran jawaban. |
| B3 | **Bibliography / References** | O | Hanya bila ada sitasi formal. Buku ini mengacu ke dokumentasi daring lewat tautan; tidak wajib. |
| B4 | **Subject index** | O (P2 untuk terbit-sendiri) | Mahal, tetapi penanda "buku sungguhan" untuk cetak/retail. Lihat §9. |
| B5 | **Colophon** (di belakang) | O | Boleh digabung ke halaman copyright; cukup satu tempat. Lihat §3. |
| B6 | **About the author** | O (W bila dijual retail) | 3–5 baris + kontak stabil. Paling lazim di paling belakang. |
| B7 | **Version history / changelog / errata** | O (naik ke W untuk buku teknis berumur panjang) | Buku ini memaku Nim 2.2.12 → halaman "versi yang diuji & errata" melindungi klaim. |
| B8 | **Closing / blurb page** | O (W bila dijual cetak) | Ringkasan nilai buku + ruang barcode bila POD. |
| B9 | **Credits / trademark notice** | O → W bila mengutip kode pihak ketiga | Sebut nama "Nim" dan lisensi pustaka yang dirujuk. |

**Urutan baku materi belakang:** Lampiran → Glosarium → Bibliografi/Referensi → Indeks →
About the author → Colophon/Closing. Errata/changelog boleh di ujung setelah colophon.

| ID | Butir | Ambang |
|---|---|---|
| B10 | Tiap lampiran dirujuk naskah | 0 lampiran yatim |
| B11 | Glosarium terfokus istilah yang dipakai buku | 0 baris "Bab: -" untuk istilah yang punya bab |
| B12 | Nomor halaman di halaman pembuka bagian/lampiran benar | cocok dengan TOC |

---

## 3. Halaman hak cipta / kolofon

Unsur **minimum** (W) dan **opsional** (O):

| ID | Unsur | Status |
|---|---|---|
| C1 | Judul buku | W |
| C2 | Subjudul (bila ada) | O |
| C3 | Nama penulis | W |
| C4 | Pernyataan hak cipta (`© <tahun> <nama>`) | W |
| C5 | Nama & alamat penerbit — atau pernyataan **diterbitkan sendiri** | W |
| C6 | ISBN (cetak / digital) + barcode | O bila ada; **jangan mengarang** |
| C7 | Lisensi teks, dengan tautan/teks kanonik yang **tidak bergantung berkas repo** | W |
| C8 | Lisensi kode + cakupannya (apa yang dianggap kode) | W |
| C9 | Versi edisi (mis. `0.6.0`) | W |
| C10 | Tanggal edisi (satu sumber, format "$bulan $tahun") | W |
| C11 | "Dicetak oleh" / printer + tahun cetak | O untuk ebook; W untuk cetak |
| C12 | Nomor cetakan / "Cetakan pertama" | O |
| C13 | Disclaimer (tanpa jaminan, merek dagang milik pemiliknya) | W untuk buku teknis |
| C14 | Alamat kontak/errata stabil (situs, repo) | O → W bila dijual |
| C15 | Kolofon produksi (trim, jenis huruf, mesin, jumlah halaman) | O |

**Contoh blok kolofon yang benar untuk buku ini** (ganti hanya angka versi/tanggal; JANGAN
mengisi ISBN karena memang tidak ada):

```
Dasar Pemrograman Nim
Belajar bahasa Nim dari nol, dalam Bahasa Indonesia

Penulis        : Fredianto
Versi          : 0.6.0
Tanggal        : 23 Oktober 2026

© 2026 Fredianto. Diterbitkan sendiri; tanpa penerbit, tanpa ISBN.

Teks buku ini dilisensikan di bawah Creative Commons
Attribution-ShareAlike 4.0 International (CC BY-SA 4.0):
https://creativecommons.org/licenses/by-sa/4.0/

Seluruh contoh kode di dalam buku dan di examples/ dilisensikan
di bawah MIT: https://opensource.org/license/mit

Nama "Nim", nama pustaka, dan nama produk lain yang disebut di
buku ini adalah milik pemegangnya masing-masing; penyebutan
dilakukan tanpa klaim afiliasi atau dukungan.

Buku ini disusun dengan Quarto dan Typst. Trim 178 × 233 mm.
Versi yang diuji: Nim 2.2.12.

Errata dan kode sumber: https://github.com/nferdazel/nim-id
Situs: https://nim.qouver.com

Diterbitkan tanpa jaminan apa pun. Penulis menolak tanggung jawab
atas kerugian yang timbul dari pemakaian isi buku ini.
```

Aturan turunan: halaman copyright **tidak boleh** menyuruh pembaca mengambil `LICENSE`/`LICENSE-CODE`
dari repositori sebagai satu-satunya sumber lisensi (C7), karena pembaca cetak/PDF tidak punya
repositori.

---

## 4. Penomoran

| Objek | Dinomori? | Skema yang lazim | Buku ini |
|---|---|---|---|
| Bagian (Part) | O | Bagian A/B/C (huruf), atau tanpa nomor | A/B/C + Lampiran |
| Bab | W | angka arabik berurutan, satu seri | 1…43 ✓ |
| Subbab | W | `1.1`, `1.2`; subsubbab `1.1.1` | `1.1` ✓ |
| Gambar | hanya bila dirujuk lintas bab | `Gambar 1.1` (per bab) | tidak ada gambar |
| Tabel | hanya bila dirujuk lintas bab | `Tabel 1.1` (per bab) | tidak ada caption bernomor |
| Persamaan | hanya bila dirujuk | `(1.1)` | tidak ada |
| Contoh kode | **tidak** dinomori; diberi label bahasa | label `nim` / `txt` | label bahasa ✓ |
| Kotak catatan ("Tujuan bab") | tidak dinomori | ikon/label | tanpa nomor ✓ |
| Latihan | tidak dinomori; daftar `1. 2. 3.` per bab | — | ✓ |
| **Jawaban** | ikut bab yang dijawab | **`A.1` = jawaban Bab 1**, `A.n` = Bab n | `A.1 … A.43` ✓ |
| Lampiran | W | `Lampiran A`, `A.1`, `A.2` | A/B/C/D; anak `A.1` ✓ |

**Cara buku besar menomori jawaban:** praktik O'Reilly/Manning adalah **bagian dalam lampiran
yang dipetakan ke nomor bab** — bukan nomor urut baru. Jadi "A.1" wajib berarti "jawaban Bab 1",
"A.17" berarti "jawaban Bab 17". Nomor bab **tidak** diulang di dalam teks jawaban; cukup label
"A.1". Di daftar isi, entri lampiran jawaban memakai awalan lampiran (`A.1`, `A.2`), bukan `1.1`.

| ID | Aturan | Ambang |
|---|---|---|
| N1 | Nomor bab kontinu, tanpa lubang/duplikat | 1…N, tepat N |
| N2 | `A.k` memetakan Bab k | 100 % |
| N3 | Nomor subbab tidak melompat level | 0 kasus `1.3` tanpa `1.2` |
| N4 | Caption gambar/tabel bernomor hanya bila ada > 8 | buku ini: 0 → tanpa list of figures/tables |
| N5 | Label bahasa pada tiap blok kode | tiap fence `{.nim}`/`{.txt}` |

---

## 5. Halaman pembuka bagian & lampiran

Halaman pembuka bagian (part opener) wajib memuat:

| ID | Isi | Status |
|---|---|---|
| P1 | Judul bagian ("Bagian A: Dasar") | W |
| P2 | Daftar bab di bagian itu **dengan nomor halaman** | W |
| P3 | Ringkasan satu paragraf (2–4 kalimat) tentang isi bagian | O (naik ke W bila bagian punya janji berbeda) |
| P4 | Tanpa folio? **Boleh ada folio**, tetapi **tanpa running head** | W |
| P5 | Himpunan pembuka konsisten: semua bagian & himpunan lampiran memakai bentuk yang sama | W |

Halaman pembuka lampiran mengikuti bentuk yang sama: `Lampiran` + daftar `A–D` + (opsional)
satu paragraf. Halaman pembuka bab memuat: label `BAB n`, judul, garis/aturan; **tanpa** running
head, **dengan** folio.

---

## 6. Tipografi & grid cetak

Ambang untuk trim 178 × 233 mm (≈ 7.0 × 9.17 in). Sesuaikan proporsional bila trim berubah.

| ID | Butir | Ambang |
|---|---|---|
| T1 | Ukuran badan | 10–11 pt |
| T2 | Tinggi baris (baseline pitch / ukuran) | 1.40–1.55 (mis. 15.4–17.0 pt pada 11 pt) |
| T3 | Panjang baris | 60–72 karakter; ≈ 110–125 mm |
| T4 | Margin dalam (gutter, sisi jilid) | ≥ 25 mm untuk jilid lem > 300 hlm (aman: 30 mm) |
| T5 | Margin luar / atas / bawah | luar ≥ 18 mm; atas ≥ 18 mm; bawah ≥ 20 mm (folio masuk hitungan) |
| T6 | Margin cermin | dalam/luar tercermin pada verso/recto |
| T7 | Running head | verso = judul buku; recto = judul bab. Mati di pembuka bab, pembuka bagian, materi depan |
| T8 | Folio | satu posisi konsisten; tidak di sampul/judul/copyright |
| T9 | Orphan/widow | minimal 2 baris di bawah judul dan 2 baris di atas halaman berikutnya |
| T10 | Judul di kaki halaman | 0 judul (h2/h3) sebagai baris terakhir halaman |
| T11 | Baris terakhir halaman | bukan baris terpotong satu kata; hindari baris berakhir dengan tanda hubung |
| T12 | Jarak antarparagraf | konsisten (mis. 1.2–1.4 em) atau indentasi konsisten — **jangan keduanya** |
| T13 | Blok kode | satu ukuran di seluruh buku; tidak menyeberang halaman tanpa aturan lanjut; tidak melewati measure |
| T14 | Tabel | baris kepala berulang di halaman lanjutan; tanpa zebra |
| T15 | Justifikasi | rata kiri (ragged right) atau justify dengan hyphenation aktif, konsisten di seluruh buku |
| T16 | Ink coverage | area tinta pekat (mis. bidang warna) < ~20 % halaman; hindari blok > 1/3 halaman hitam |

---

## 7. Kualitas produksi

| ID | Butir | Ambang / cara cek |
|---|---|---|
| Q1 | Metadata PDF: Title, Author, Subject, Keywords | ada (`pdfinfo`) |
| Q2 | Bahasa dokumen (`/Lang`) | sesuai edisi (`id` / `en`) |
| Q3 | Font tertanam & subset | 100 % (`pdffonts`) |
| Q4 | Tagged PDF (aksesibilitas) | ya (`pdfinfo` → Tagged) |
| Q5 | Bookmark/outline | mengikuti struktur TOC; **bagian/lampiran juga di-bookmark** |
| Q6 | Tautan internal (TOC, silang) dapat diklik | TOC 100 % |
| Q7 | Alt text | wajib bila ada gambar; buku ini tanpa gambar |
| Q8 | Trim | ukuran didukung percetakan yang dituju (POD: 5×8, 5.5×8.5, 6×9, 7×10 in dsb.) |
| Q9 | Bleed | 3 mm **hanya** untuk berkas sampul yang penuh; isi tanpa bleed |
| Q10 | Sampul terpisah | berkas isi **tanpa** halaman sampul; berkas sampul sendiri (depan + spine + belakang) |
| Q11 | PDF/A / PDF-X | hanya bila diklaim; jangan klaim tanpa bukti |
| Q12 | Ukuran berkas & objektif PDF | wajar untuk distribusi (mis. < 15 MB) |
| Q13 | Tidak ada rahasia (kunci API, email pribadi) di metadata | 0 |

Untuk POD dihitung dulu: lebar spine ≈ jumlah halaman × tebal kertas (mis. 0,0572 mm/hlm × 393
≈ 22,5 mm) untuk kertas putih; unggah sebagai sampul terpisah.

---

## 8. Dua bahasa (ID ↔ EN)

**Wajib identik:**
- Jumlah & urutan bab (43) dan lampiran (A–D).
- Skema penomoran (bab, subbab, `A.k`, lampiran).
- Blok kode dan output yang identik (kode berbahasa Inggris di kedua edisi).
- Himpunan lampiran & glosarium.
- Struktur halaman copyright/kolofon (unsur yang sama, terjemahan wajar).
- Grid tipografi: trim, margin, ukuran badan, tinggi baris, ukuran kode.
- Skema metadata PDF & kedalaman bookmark.

**Boleh berbeda:**
- Prosa, judul bab, judul bagian.
- Jumlah halaman & nomor halaman (karena panjang teks berbeda).
- Teks running head & TOC.
- Tanggal dalam format lokal (`23 Oktober 2026` vs `23 October 2026`).

| ID | Aturan | Ambang |
|---|---|---|
| L1 | Paritas struktur | 43/43 bab, 4/4 lampiran, sama urutan |
| L2 | Paritas blok kode | jumlah & isi fence `{.nim}`/`{.txt}` sama |
| L3 | Paritas grid | margin & ukuran font sama |
| L4 | Paritas metadata | kunci metadata sama, hanya nilai yang diterjemahkan |

---

## 9. Ceklis eksekusi (jalankan sebelum menyatakan "terbit")

```text
FRONT MATTER
[ ] F3  title page ada, tanpa folio
[ ] F4  copyright page di verso setelah title page
[ ] F6  TOC ada; tiap nomor cocok dengan folio tercetak
[ ] F7  preface ada dan menyebut "untuk siapa" + "cara membaca"
[ ] F13 halaman judul/copyright tanpa folio tercetak
[ ] F14 satu sistem nomor untuk materi depan

COPYRIGHT / COLOPHON
[ ] C1–C5, C7–C10, C13 lengkap
[ ] C7  lisensi dapat diverifikasi tanpa mengakses repositori
[ ] C6  ISBN hanya bila benar ada

NUMBERING
[ ] N1  bab 1..N tanpa lubang
[ ] N2  A.k = Bab k
[ ] N5  label bahasa di tiap blok kode

PART / APPENDIX OPENERS
[ ] P2  daftar bab + nomor halaman
[ ] P4  tanpa running head
[ ] P5  bentuk seragam untuk semua bagian & lampiran

TYPOGRAPHY
[ ] T2  tinggi baris 1.40–1.55
[ ] T3  measure 60–72 karakter
[ ] T4  gutter >= 25 mm
[ ] T7  running head verso/recto benar, mati di pembuka
[ ] T9–T11 orphan/widow, judul di kaki halaman, baris terakhir
[ ] T15 satu mode justifikasi di seluruh buku

PRODUCTION
[ ] Q1–Q4 metadata, /Lang, embed+subset, tagged
[ ] Q5  bookmark termasuk Bagian & Lampiran
[ ] Q8–Q10 trim didukung + berkas isi tanpa sampul + sampul terpisah
[ ] Q13 0 rahasia di metadata

LANGUAGE PAIR
[ ] L1  L4 paritas struktur, kode, grid, metadata
```

**Berkas sasaran bila ada yang gagal** (ringkas — detail di §10):

| Wilayah | Berkas |
|---|---|
| Kerangka halaman, folio, running head, grid, centerpiece bagian | `assets/typst/typst-show.typ` |
| Daftar bab, maskot format, metadata Quarto | `books/{id,en}/_quarto.yml` |
| Urutan & isi materi depan/belakang | `books/{id,en}/_quarto.yml` (bagian `book:`) |
| Kolofon, lisensi, kredit, kontak | `books/{id,en}/copyright.qmd` |
| Prakata, tentative, errata | `books/{id,en}/index.qmd` |
| Keputusan strategis (trim, ISBN, jual/gratis) | pemilik buku — bukan agen |

---

## 10. Praktik penerbit sebagai pembanding

- **O'Reilly** — front matter ramping (title, copyright, TOC, preface); indeks subjek adalah
  bagian wajib; errata dikelola di halaman produk; kolofon produksi di belakang.
- **Manning** — "About the author" di belakang; indeks cetak lengkap; bab selalu dibuka dengan
  ringkasan + diakhiri latihan; halaman bagian memuat daftar bab.
- **No Starch Press** — front matter minimum untuk buku teknis; lisensi/kredit ditulis eksplisit;
  nomor jawaban latihan dipetakan per bab.
- **Pragmatic Bookshelf** — model terbit-sendiri: tanpa half title, tanpa sampul internal,
  kolofon ringkas, errata daring; trim nyaman untuk cetak kecil.
- **Addison-Wesley / Pearson** — aturan orphan/widow ketat; penomoran subbab tiga tingkat;
  indeks nama + subjek.

Yang **tidak perlu** dipaksakan untuk terbit-sendiri: half title, frontispiece, indeks subjek
profesional penuh, komite/ISBN palsu, PDF/A-2b, sampul hardcover, dan kolofon produksi rinci.
