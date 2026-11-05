# Rencana: Buku Nim Bahasa Indonesia, repo `nim-id`, situs `nim.qouver.com`

Status per 5 Nov 2026: **isi M3 selesai, tag `v1.0.0` belum** — 43 bab dua bahasa, 323 program
contoh terverifikasi (324 berkas `.nim`, termasuk satu modul pendukung `textutils/format.nim`),
PDF 415 halaman Indonesia / 407 halaman English, versi `0.7.11`, Nim 2.4.0.

Rencana di bawah ditulis 23 Okt 2026 saat M2. Angka yang menyebut M0/M2 adalah catatan historis
pada tanggal itu, bukan keadaan sekarang.

---

## 1. Ringkasan keputusan

1. **Satu sumber Markdown** (`.qmd`), dirender jadi **web + PDF** oleh **Quarto**, dengan PDF lewat **Typst** (bukan Prince, bukan LaTeX kecuali terpaksa).
2. **Nada dan struktur** mengambil yang sudah terbukti dari novalagung (error-first, imperatif, bab pendek), **bukan** menyalin isi atau tech stack-nya.
3. **Snippet kode diverifikasi compiler di CI** dan output-nya di-*generate*, bukan screenshot. Ini pembeda utama vs buku aslinya.
4. **Deploy static** ke VPS lewat **subset** kontrak emas (ref-guard + flock + rsync + symlink swap), tanpa podman, tanpa tag image. Bukan karena aturan, tapi karena kontrak penuh memecahkan masalah yang tidak dimiliki situs statis.
5. **Rilis bertahap**: tiap bab yang selesai langsung terbit. Buku tidak ditahan sampai semua bab kelar.

---

## 2. Kenapa Quarto, bukan Docusaurus + Prince

| Pendekatan | Kualitas PDF | Kompleksitas | Catatan |
|---|---|---|---|
| **Quarto → Typst** (rekomendasi) | tinggi (tipografi buku asli, tagged PDF) | 1 tool, 1 sumber | Quarto 1.10 punya *typst book*; kalau bermasalah, pindah ke LaTeX dari sumber yang sama |
| Docusaurus + Prince | sedang (hasil cetak = website yang di-print) | 2 config + Prince berbayar untuk komersial | ini yang dipakai novalagung |
| Docusaurus + paged.js/Vivliostyle | sedang, rapuh di footnote/widow | 2 tool + CSS paged media tangan | bukan jalan pintas |
| mdBook | PDF lewat jalur tidak resmi | rendah untuk web | tidak ada jalur PDF yang layak |
| Typst langsung (`.typ`) | tertinggi | konten terduplikasi dari web | hanya jika PDF jadi produk utama, web nomor dua |

Alasan memilih Quarto:

- **Satu sumber, dua keluaran.** Menulis dua kali (web + PDF) adalah kesalahan klasik yang bikin bab tidak sinkron.
- **Typst memberi tipografi buku sungguhan**: hyphenation, widow/orphan, running header, TOC dengan dot leader, cross-reference bernomor, tagged PDF. Prince dari HTML selalu terasa "website yang dicetak".
- **Callout, code annotation, cross-ref sudah built-in**: persis kebutuhan buku pemrograman.
- Biaya build kecil: Typst satu biner, render detik, tidak perlu TinyTeX ~1 GB.

**Escape hatch:** isi tetap Markdown polos + callout standar. Kalau Quarto/Typst menyakitkan, pindah ke Docusaurus atau LaTeX tanpa menulis ulang isi. Jangan pakai fitur eksotis Quarto di luar: heading, code block, callout, gambar, tabel, footnote.

**Sudah diverifikasi di M0 (23 Okt 2026, Quarto 1.10.19, Nim 2.2.12 — Nim naik ke 2.4.0 pada
0.7.10):**

- *Syntax highlighting Nim.* Klaim awal bahwa Pandoc/skylighting tidak mendukung Nim **salah**.
  `quarto pandoc --list-highlight-languages` memuat `nim`, dan hasil render benar-benar
  menghasilkan token (`kw`, `st`, `fu`, `dv`). Tidak perlu `--syntax-definition` atau `nim.xml`.
- *Typst book.* Berjalan: `format: typst` + `project: type: book` menghasilkan PDF 13 halaman
  dari 3 berkas sumber, 197 KB.
- *Satu direktori keluaran.* `output-dir` di tingkat **format** diabaikan pada project book;
  HTML dan PDF harus berbagi `project.output-dir` (dipakai `_site`).

---

## 3. Desain PDF ("biar lebih indah")

Ukuran & grid:

- Trim **7 × 9,19 inci** (178 × 233 mm), standar buku teknis; kolom teks 119 mm, baris kode
  panjang membungkus di spasi (tidak memotong measure).
- Margin 29,5 mm kiri-kanan, 21 mm atas, 25 mm bawah, tanpa margin cermin (yang terpasang di
  `assets/typst/typst-show.typ`).
- Badan **11 pt** serif, **rata kiri** tanpa justify, jarak antarparagraf 1,3 em, tanpa indentasi baris pertama.
- Kode monospace ukuran lebih kecil dari badan, latar abu hangat, blok pendek tidak dipotong antarhalaman bila masih muat.

Elemen yang menentukan kesan "buku", bukan "print website":

- **Blok kode vs blok output dibedakan jelas.** Kode: latar abu hangat `#F4F1EA`, garis tipis. Output: latar sama, label kecil `output`, garis kiri 2px aksen. Output di-generate dari eksekusi nyata, bukan screenshot.
- **Screenshot maksimal 1 per 5 bab**, hanya untuk hal yang benar-benar visual: pesan error compiler berwarna, TUI, hasil grafis. Sisanya teks agar bisa di-copy, di-search, dan ramah pembaca tunanetra.
- **Callout 3 jenis** (Catatan / Peringatan / Tips): garis kiri 2px aksen, latar transparan. Wajib diuji **cetak hitam-putih**: jangan mengandalkan warna.
- **Highlighting aman-grayscale & buta warna**: keyword bold, comment muted, tanpa mengandalkan merah/hijau untuk membedakan token.
- **Nomor baris hanya di bab debug** ("kenapa error di baris 7"), tidak di semua blok.
- **Running header** judul bab, nomor halaman bawah tengah, TOC 2 level dengan dot leader, daftar istilah di belakang.
- **Cover** dari template Typst 1 halaman, bukan gambar 3 MB.
- **Target ukuran file < 8 MB.** Audiens Indonesia banyak membaca dan membagikan buku lewat WhatsApp/Telegram; PDF 40 MB tidak akan dibaca.
- **Tagged PDF** (terpasang). PDF/A-2b tidak dipakai: Typst belum menghasilkan PDF/A dari Quarto,
  jadi klaim itu dicabut.
- Nama berkas rilis: `Dasar-Pemrograman-Nim.pdf` dan `public/en/Learning-Nim.pdf`; versi
  disematkan sebagai `?v=<VERSION>` saat build, bukan di nama berkas. Metadata judul/penulis/versi
  Nim terisi.

---

## 4. Pedoman bahasa dan bentuk bab

Aturan mengikat ada di [`writing-guide.md`](writing-guide.md); istilah ada di
[`glossary.md`](glossary.md). Dokumen ini tidak mengulanginya. Ringkasnya: pembaca sudah bisa
menulis program, suara imperatif dan "kita", kalimat ≤ 20 kata, satu bab 900–1.400 kata dengan
hook–konsep–error-first–latihan.

Satu catatan rencana yang tidak ada di pedoman: audiens sengaja disamakan dengan pembaca buku Rust
novalagung, yaitu orang yang penasaran Nim karena mendengar "sintaks Python, cepat seperti C".

---

## 5. Deployment: apakah harus lewat infra sendiri?

**Jawaban singkat: tidak harus, dan kontrak penuhnya tidak relevan.** Tapi memakai infra sendiri itu murah kalau hanya mengambil bagian yang relevan.

Alasannya: kontrak emas di `AGENTS.md` dirancang untuk **service stateful**: migrasi DB, container, rollback image, retensi `:local`/`:prev`. Buku adalah **direktori file statis**. Tidak ada state, tidak ada container, tidak ada image. Memaksakan `podman tag :prev` untuk situs statis hanya menambah bagian yang tidak pernah dipakai.

Yang tetap relevan, dan tetap dipakai:

| Bagian kontrak | Untuk buku statis |
|---|---|
| Ref-guard fail-closed (`refs/heads/main`) | **dipakai**: sama persis |
| `flock` concurrency | **dipakai**: dua deploy bersamaan tetap merusak swap |
| `git fetch && git reset --hard` | **dipakai** |
| Tag image `:local`/`:prev` | **tidak relevan** (tidak ada image) |
| Rollback | diganti **symlink swap**: `releases/<sha>/`, symlink `web` → rilis aktif, rilis lama disimpan di `.previous` |
| Health gate | versi ringan: `curl` ke origin lewat HTTP port 80 + `Host`, cek judul kedua edisi |
| Retensi | **3 rilis terakhir**, sisanya dihapus (padanan anti-disk-bloat) |

### Pilihan hosting

| Opsi | Biaya | Kontrol | Preview per PR | Catatan |
|---|---|---|---|---|
| **VPS + Caddy** (rekomendasi) | 0 (sudah ada) | penuh (header, cache, redirect) | opsional | `nim.qouver.com`; pola sama dengan `skyward`/`sds` yang memang menyajikan `root * /srv/qouver/apps/<app>/web` |
| GitHub Pages | 0 | rendah (header terbatas) | tidak | paling cepat jadi; domain `github.io` kurang untuk branding, tapi custom domain bisa |
| Cloudflare Pages | 0 | sedang | ya | CDN global + preview per PR; tapi keluar dari infra sendiri dan menambah satu dashboard lagi |

**Rekomendasi:** VPS, subdomain `nim.qouver.com`. Render terjadi di dua tempat dari commit yang
sama: VPS saat deploy (hasilnya yang disajikan) dan GitHub Actions saat tag `v*` (PDF-nya ditempel
ke GitHub Releases). Langkah operasional ada di [`deploy-vps.md`](deploy-vps.md), tidak diulang di
sini.

Alur:

```
push ke main
  ├─ CI: verify examples → paritas/glosarium → render html + pdf → artifact (tidak dipakai VPS)
  └─ webhook VPS → deploy-static.sh: ref-guard → flock → fetch/reset → build-site.sh
       → rsync ke releases/<sha>/ → health check → swap symlink → prune 3 rilis
tag v*
  └─ CI: cek tag == VERSION → render ulang → upload kedua PDF sebagai aset GitHub Release
```

Catatan DNS & server (dicatat 23 Okt 2026, dicocokkan dengan catatan server di `vps/SERVER_STATE.md`):

- Record: `A nim → 43.133.148.19`, **proxied (orange)** seperti 7 nama lain; SSL mode Cloudflare sudah `Full (strict)`.
- Karena proxied, origin wajib punya sertifikat valid untuk `nim.qouver.com`; Caddy menerbitkannya otomatis (HTTP-01, port 80 tetap terbuka ke Cloudflare).
- Path baru `/srv/qouver/apps/nim-id/web` butuh aturan `semanage fcontext` + `restorecon` **sekali** (sama seperti `kran`/`sds`). Tanpa itu Caddy balas 403/404 meski file ada.
- Saat blok Caddy belum terpasang (23 Okt), `nim.qouver.com` menjawab **525**. Itu normal, bukan tanda DNS salah.
- Sejak 2 Nov 2026 Zone-level Authenticated Origin Pulls aktif: TLS langsung ke origin tanpa client
  cert gagal, jadi health check memakai HTTP port 80 + header `Host` (lihat `deploy-vps.md`).

Script deploy static: satu berkas bash tanpa podman, di `ops/scripts/deploy-static.sh`; cermin blok
Caddy ada di `ops/caddy/Caddyfile.nim-id.example`; hook webhook HMAC tetap dipakai.

---

## 6. Struktur repo

```
nim-id/
├── task                       # pintu perintah POSIX (bukan Taskfile; pola repo cbs)
├── books/
│   ├── id/                    # project Quarto Indonesia → akar situs
│   │   ├── _quarto.yml
│   │   ├── index.qmd
│   │   ├── chapters/
│   │   └── appendix/
│   └── en/                    # project Quarto English → /en/, nama berkas sama
│       ├── _quarto.yml
│       ├── index.qmd
│       ├── chapters/
│       └── appendix/
├── examples/                  # 42 folder contoh, dipakai kedua bahasa
│   └── variables/             # contoh: aNN_nama.nim + .expected / .expected-error
├── assets/ku.css              # sumber tunggal CSS; disalin ke tiap buku saat build
├── tools/
│   ├── build-site.sh          # render keduanya → public/ dan public/en/
│   ├── verify-examples.sh
│   ├── lint-glossary.py
│   ├── check-parity.py / check-appendix.py / check-glossary-page.py
│   ├── gen-version.sh / sync-assets.sh / release.sh
│   └── fix-skip-link.py / typst-links.lua
├── docs/                      # plan, writing-guide, publishing-standards, release, deploy-vps, glossary
├── ops/                       # Caddy block, setup-vps.sh, deploy-static.sh
└── .github/workflows/ci.yml
```

Tidak memakai `apps/` + `modules/`: itu untuk aplikasi dengan backend. Buku bukan monorepo
modular, dan memaksakan struktur itu hanya menambah folder kosong.

### 6.1 i18n

Dua **project Quarto terpisah**, bukan profil. Alasannya teknis: Quarto menuntut `index.qmd` di
akar project, dan `output-dir`/`book.chapters` di tingkat format tidak bisa memindahkan akar
tersebut. Dua project memberi URL bersih tanpa penyesuaian.

| | Indonesia | English |
|---|---|---|
| Project | `books/id/` | `books/en/` |
| URL | `/` | `/en/` |
| PDF | `Dasar-Pemrograman-Nim.pdf` | `Learning-Nim.pdf` |

Aturan:

- **Nama berkas sama di kedua bahasa** dan **kode contoh ditulis Inggris lalu dipakai bersama**;
  aturan penulisan/terjemahannya ada di [`writing-guide.md`](writing-guide.md), bukan diulang di sini.
- `tools/build-site.sh` merender kedua project lalu menyatukannya ke `public/`; deploy hanya
  menyentuh `public/`.
- CSS bersama di `assets/ku.css` disalin ke tiap project saat build (Quarto tidak menyalin berkas
  di luar direktori project, dan symlink tidak diikuti). Salinan tidak di-commit.
- Tanpa plugin i18n pihak ketiga (Babelquarto dan sejenisnya): menambah toolchain R tanpa manfaat
  sepadan.

---

## 7. Kerangka bab (43 bab + 5 lampiran)

Bagian dan urutan persisnya ada di `books/{id,en}/_quarto.yml`; daftar ini ringkasannya.

**Bagian A, Dasar (16):** Apa itu Nim dan kenapa; Instalasi; Alur kerja (`nim c -r`, `nimble`,
editor); Komentar & doc comment; Variabel `var`/`let`/`const`; Tipe dasar & literal; String & raw
string; `echo` & format; Operator; `if`/`case`/`when`; Perulangan; `array`/`seq`/`openArray`;
`proc`, parameter, nilai balik; Tuple; Object; Enum & set.

**Bagian B, Menengah (17):** Module & `import`/`export`; Exception & `raises`; Iterator & `yield`;
Closure; Generic; Template; Macro; Concept; Object variant & `distinct`; `ref`/`ptr`/`nil`; ARC/ORC &
`=destroy`; Tur pustaka standar (`strutils`, `sequtils`, `tables`, `json`); File & OS; `unittest`;
`async`/`await`; FFI ke C; compile ke JS.

**Bagian C, Praktik (10):** CLI dengan `cligen`; HTTP API (mummy/jester); Database (`norm`);
Membuat & menerbitkan paket nimble; Benchmark & profiling; Cross-compile & deploy biner; Regex;
Waktu & acak; Thread; Proyek akhir.

**Lampiran (5 + kolofon):** A Jawaban latihan; B Glosarium; C Cheat sheet; D Nim untuk programmer
Python/Go/Rust; E Referensi dan bacaan lanjutan; kolofon di paling belakang.

Bab yang **tidak** diambil dari buku Rust karena khas Rust: ownership, borrowing, lifetime, `use`/`path-item`, operator `?`, slice memory management.

---

## 8. Milestone

| Tahap | Isi | Estimasi | Gate |
|---|---|---|---|
| **M0** vertical slice | Skeleton repo, `_quarto.yml`, CI verify 3 snippet, **1 bab utuh** (Variabel), web + PDF 20 halaman, deploy `nim.qouver.com` | 2–3 hari | Baca di HP; cetak hitam-putih; highlight Nim tampil; PDF < 8 MB |
| **M1** fondasi | Bagian pembuka + A (16 bab), glosarium 60 istilah, latihan + jawaban | 2–3 minggu | 16 bab DoD lengkap, CI hijau |
| **M2** menengah | Bagian B (17 bab) | 4–6 minggu | sama |
| **M3** praktik & rilis | Bagian C + D, polish PDF, tag `v1.0.0` | 3–4 minggu | PDF rilis + web stabil |

Total realistis **3–4 bulan** kerja konsisten. Publikasi per bab sejak M1; jangan menunggu M3.

Tabel di atas adalah rencana 23 Okt 2026. Realisasi 5 Nov 2026: M0–M3 isi selesai (43 bab + 5
lampiran), tetapi tag `v1.0.0` belum dibuat; versi berjalan `0.7.11`.

---

## 9. Risiko

| Risiko | Mitigasi |
|---|---|
| Typst book masih muda | Sudah terbukti jalan di 1.10.19 (§2); escape hatch ke LaTeX dari sumber sama |
| Highlighting Nim | Terverifikasi didukung (§2); tidak perlu mitigasi |
| Istilah & ejaan melenceng antar bab | `docs/glossary.md` + lint CI untuk varian terlarang |
| Snippet basi saat Nim naik versi | Versi Nim dipin di CI, golden output memaksa snippet diperbarui saat upgrade |
| SEO: "NIM" = nomor induk mahasiswa | Selalu tulis "bahasa Nim" di judul/deskripsi, slug `belajar-nim`, structured data, judul buku eksplisit |
| Solo, 43 bab | 3 bab/minggu, terbit bertahap, tiap bab satu PR kecil |
| PDF membengkak | Tanpa screenshot besar; gambar SVG; target < 8 MB dicek di CI |

---

## 10. Keputusan

Sudah dikunci (23 Okt 2026):

1. **Nama repo `nim-id`.** Alasan: nama repo tidak memengaruhi SEO (situs ada di domain sendiri). `dasarpemrogramannim` ambigu dengan "NIM = nomor induk mahasiswa", dan `nim-id` bisa menampung glosarium/kurikulum/playground tanpa mengunci diri jadi satu buku.
2. **Domain `nim.qouver.com`** (pemilik menyiapkan record-nya).
3. **Judul buku terpisah dari nama repo**: "Dasar Pemrograman Nim: Bahasa Indonesia". Judul inilah yang jadi `<title>`, H1, dan slug halaman.
4. **Lisensi**: teks CC BY-SA 4.0 + kode contoh MIT.

Semua keputusan di atas sudah dijalankan. Izin M0 (repo, blok Caddy, deploy pertama) sudah selesai
— lihat §11. Tidak ada butir yang masih terbuka.

Nama folder kerja sudah ikut diganti: `~/Projects/nim-book` → `~/Projects/nim-id`.

---

## 11. Status M0 (23 Okt 2026)

Sudah ada di `~/Projects/nim-id`:

- Quarto 1.10.19 di `~/.local/opt` (tanpa sudo) dan Nim 2.2.12 (naik ke 2.4.0 pada 0.7.10).
- Satu bab utuh (Variabel) + 8 contoh yang dikompilasi dan diverifikasi: `bash tools/verify-examples.sh` → `8 lulus, 0 gagal` (diukur saat M0).
- Render web + PDF dari satu sumber. PDF 13 halaman, 197 KB (diukur saat M0).
- Kerangka CI, blok Caddy, `deploy-static.sh`, glosarium, pedoman penulisan, jawaban latihan.
- VPS: direktori `/srv/qouver/apps/nim-id/` + placeholder satu halaman sudah terpasang
  (`web -> releases/placeholder`), Quarto 1.10.19 ada di `.tools/quarto`. Saat itu blok Caddy
  belum terpasang karena butuh `sudo`; blok dipasang setelah M0 (lihat daftar di bawah).

Temuan yang mengubah rencana:

1. **`papersize` diabaikan pada project book.** Dokumen tunggal menghormatinya, book tetap A4.
   Penyebabnya: template `orange-book` memakai parameter `paper-size`/`width`/`height`, bukan
   `papersize`. Solusi (sudah terpasang): override `template-partials: assets/typst/typst-show.typ`
   lalu isi `width: 178mm, height: 233mm`. Hasil terukur: 504,6 × 660,5 pt = 178 × 233 mm.
2. **Label struktural awalnya Inggris** ("Contents", "Appendices") karena `lang` tidak sampai ke
   template typst. Solusi: `format: typst: lang: id` (Quarto sudah punya `_language-id.yml`),
   menghasilkan "Daftar Isi" dan "Lampiran".
3. **Struktur awal (satu project + profil) tidak bisa dipakai.** Quarto menuntut `index.qmd` di
   akar project, dan `output-dir` per format diabaikan pada book. Solusinya dua project terpisah
   (`books/id`, `books/en`), yang sekaligus memberi URL bersih.
4. **Nama berkas contoh wajib `aNN_nama.nim`**; Nim menolak nama modul yang dimulai angka atau
   memakai tanda hubung.
5. **`echo` tidak menambahkan pemisah** antar argumen (terverifikasi lewat `a04`).
6. Highlighting Nim **didukung** Pandoc/Quarto; klaim awal di §2 keliru dan sudah dikoreksi.

Tambahan 23 Okt 2026 (setelah M0):

- [x] Blok Caddy + label SELinux. Caddyfile memakai `admin off` (audit H-5), jadi perubahan
      konfigurasi butuh `systemctl restart caddy`, bukan `reload`. Skrip `setup-vps.sh` sudah
      menyesuaikan.
- [x] i18n: dua project Quarto (`books/id`, `books/en`), nama berkas sama, contoh dipakai bersama,
      penyusunan lewat `tools/build-site.sh`.
- [x] Deploy manual pertama: `public/` → `releases/m0-20261023-1429`, symlink `web` diganti.
      Semua rute utama 200 (`/`, `/en/`, `/chapters/variables.html`, PDF, CSS).

Status per 5 Nov 2026:

- [x] Deploy otomatis lewat webhook: repo GitHub `nferdazel/nim-id` (publik), hook `nim-id` di
      `/srv/qouver/config/webhook.json` (HMAC-SHA256), `monorepo/` di server.
- [x] Trim PDF 178 × 233 mm + label Indonesia ("Daftar Isi", "Lampiran"). Margin 29,5 mm
      kiri-kanan, 21 mm atas, 25 mm bawah, ukuran huruf 11 pt, diatur di `assets/typst/typst-show.typ`.
- [x] CI sudah berjalan di GitHub (badge di `README.md`).
- [x] Halaman 404 + skip link: blok `handle_errors` di Caddy, `tools/fix-skip-link.py`.
- [ ] Tag `v1.0.0` belum dibuat; rilis berjalan berhenti di `v0.7.11`.
