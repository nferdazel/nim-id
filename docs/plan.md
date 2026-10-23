# Rencana: Buku Nim Bahasa Indonesia, repo `nim-id`, situs `nim.qouver.com`

Status: **M2 selesai** (33 bab dua bahasa, 254 contoh terverifikasi, PDF 244 halaman Indonesia / 237
halaman English). Audit teknis tiga gelombang sudah dibereskan; menunggu izin rilis dan push.
Tanggal: 23 Okt 2026. Target tool: Nim 2.2.x.

---

## 1. Ringkasan keputusan

1. **Satu sumber Markdown** (`.qmd`), dirender jadi **web + PDF** oleh **Quarto**, dengan PDF lewat **Typst** (bukan Prince, bukan LaTeX kecuali terpaksa).
2. **Nada dan struktur** mengambil yang sudah terbukti dari novalagung (error-first, imperatif, bab pendek), **bukan** menyalin isi atau tech stack-nya.
3. **Snippet kode diverifikasi compiler di CI** dan output-nya di-*generate*, bukan screenshot. Ini pembeda utama vs buku aslinya.
4. **Deploy static** ke VPS lewat **subset** kontrak emas (ref-guard + flock + rsync + symlink swap), tanpa podman, tanpa tag image. Bukan karena aturan, tapi karena kontrak penuh memecahkan masalah yang tidak dimiliki situs statis.
5. **Rilis bertahap**: tiap bab yang selesai langsung terbit. Buku tidak ditahan sampai 50 bab kelar.

---

## 2. Kenapa Quarto, bukan Docusaurus + Prince

| Pendekatan | Kualitas PDF | Kompleksitas | Catatan |
|---|---|---|---|
| **Quarto → Typst** (rekomendasi) | tinggi (typografi buku asli, PDF/A, tagged) | 1 tool, 1 sumber | Quarto 1.10 punya *typst book*; kalau bermasalah, pindah ke LaTeX dari sumber yang sama |
| Docusaurus + Prince | sedang (hasil cetak = website yang di-print) | 2 config + Prince berbayar untuk komersial | ini yang dipakai novalagung |
| Docusaurus + paged.js/Vivliostyle | sedang, rapuh di footnote/widow | 2 tool + CSS paged media tangan | bukan jalan pintas |
| mdBook | PDF lewat jalur tidak resmi | rendah untuk web | tidak ada jalur PDF yang layak |
| Typst langsung (`.typ`) | tertinggi | konten terduplikasi dari web | hanya jika PDF jadi produk utama, web nomor dua |

Alasan memilih Quarto:

- **Satu sumber, dua keluaran.** Menulis dua kali (web + PDF) adalah kesalahan klasik yang bikin bab tidak sinkron.
- **Typst memberi tipografi buku sungguhan**: hyphenation, widow/orphan, running header, TOC dengan dot leader, cross-reference bernomor, PDF/A + tagged PDF. Prince dari HTML selalu terasa "website yang dicetak".
- **Callout, code annotation, cross-ref sudah built-in**: persis kebutuhan buku pemrograman.
- Biaya build kecil: Typst satu biner, render detik, tidak perlu TinyTeX ~1 GB.

**Escape hatch:** isi tetap Markdown polos + callout standar. Kalau Quarto/Typst menyakitkan, pindah ke Docusaurus atau LaTeX tanpa menulis ulang isi. Jangan pakai fitur eksotis Quarto di luar: heading, code block, callout, gambar, tabel, footnote.

**Sudah diverifikasi di M0 (23 Okt 2026, Quarto 1.10.19, Nim 2.2.12):**

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

- Trim **7 × 9,19 inci** (178 × 233 mm), standar buku teknis; cukup lebar untuk kode 80 kolom di 9 pt.
- Margin 16 mm kanan-kiri, 18 mm atas-bawah (yang terpasang di `assets/typst/typst-show.typ`).
- Badan **10 pt** serif, **rata kiri** tanpa justify, jarak antarparagraf 1,3 em, tanpa indentasi baris pertama.
- Kode monospace ukuran lebih kecil dari badan, latar abu hangat, blok pendek tidak dipotong antarhalaman bila masih muat.

Elemen yang menentukan kesan "buku", bukan "print website":

- **Blok kode vs blok output dibedakan jelas.** Kode: latar putih, border tipis. Output: latar abu 4%, label kecil `output`, prompt `$` untuk terminal. Output di-generate dari eksekusi nyata, bukan screenshot.
- **Screenshot maksimal 1 per 5 bab**, hanya untuk hal yang benar-benar visual: pesan error compiler berwarna, TUI, hasil grafis. Sisanya teks agar bisa di-copy, di-search, dan ramah pembaca tunanetra.
- **Callout 3 jenis** (Catatan / Peringatan / Tips): border kiri 3 pt + tint. Wajib diuji **cetak hitam-putih**: tint 4–8% saja, jangan mengandalkan warna.
- **Highlighting aman-grayscale & buta warna**: keyword bold, comment muted, tanpa mengandalkan merah/hijau untuk membedakan token.
- **Nomor baris hanya di bab debug** ("kenapa error di baris 7"), tidak di semua blok.
- **Running header** judul bab, nomor halaman bawah tengah, TOC 2 level dengan dot leader, daftar istilah di belakang.
- **Cover** dari template Typst 1 halaman, bukan gambar 3 MB.
- **Target ukuran file < 8 MB.** Audiens Indonesia banyak membaca dan membagikan buku lewat WhatsApp/Telegram; PDF 40 MB tidak akan dibaca.
- **PDF/A-2b + tagged** (Quarto: `pdf-standard: [a-2b, ua-1]`) untuk arsip dan pembaca layar.
- Nama file rilis: `Dasar-Pemrograman-Nim-v1.0.0.pdf`, metadata judul/penulis/versi Nim terisi.

---

## 4. Pedoman bahasa: bikin orang cepat paham

### 4.1 Audiens dan prasyarat

Pembaca diasumsikan **sudah pernah menulis program** (variabel, loop, fungsi di Python/JS/PHP), tapi belum pernah menyentuh bahasa sistem. Ini audiens yang sama dengan buku Rust-nya novalagung, dan audiens paling realistis: mereka yang penasaran Nim karena mendengar "sintaks Python, cepat seperti C".

Konsekuensinya: **jangan** menjelaskan apa itu variabel selama satu halaman; **jelaskan** apa yang berbeda di Nim (`var` vs `let` vs `const`, `seq` vs `array`, ARC/ORC).

### 4.2 Suara

- **Imperatif** untuk instruksi: "Tulis kode berikut", "Jalankan", "Hapus baris 4".
- **"Kita"** untuk langkah bersama: "Sekarang kita tambahkan parameter kedua."
- **"Pembaca"** saat membahas kesalahpahaman: "Di titik ini pembaca sering mengira `let` sama dengan `const`."
- Pilih satu, jangan campur. **"Anda" dilarang** (kaku). **"Lu/gue" dilarang** (buku, bukan thread Twitter).
- Tanpa emoji. Ikon diganti penanda tipografis di callout.

### 4.3 Kalimat dan paragraf

- Rata-rata **≤ 20 kata** per kalimat. Satu ide per paragraf, **≤ 4 baris**.
- Kalimat aktif. "Compiler menolak baris ini karena X", bukan "baris ini ditolak oleh compiler dikarenakan X".
- Buang basa-basi: "pada era digital ini", "seperti yang kita ketahui", "tentu saja", "perlu diingat bahwa" (kecuali benar-benar perlu diingat).
- Batasi frasa favorit jadi maksimal **1× per bab**: "kurang lebih seperti berikut", "sebagai berikut", "oke", "nah".
- Setiap klaim teknis harus bisa diuji, dan sebut versinya: "diuji di Nim 2.2.12".

Contoh:

> ❌ "Pada kesempatan kali ini, kita akan membahas mengenai konsep variabel yang mana merupakan salah satu konsep fundamental dalam bahasa pemrograman Nim."
>
> ✅ "Variabel adalah nama untuk sebuah nilai. Di Nim, variabel dideklarasikan dengan `var`."

### 4.4 Istilah

Ejaan mengikuti **EYD V**. Istilah asing yang belum mapan dicetak *miring*.

**Dipertahankan apa adanya** (jangan diterjemahkan paksa): compiler, compile-time, runtime, macro, template, iterator, closure, sequence, tuple, object, generic, pragma, FFI, binding, garbage collector, stack/heap.

**Diterjemahkan konsisten**: variabel, fungsi, prosedur (`proc`), parameter, argumen, perulangan, percabangan, tipe data, nilai balik, pengecualian (*exception*), pustaka standar, modul, paket.

**Keputusan istilah disimpan di `docs/glossary.md`** (istilah ID, istilah EN, definisi satu kalimat, bab pertama kali muncul). Glosarium **di-lint di CI**: kalau sebuah bab memakai varian terlarang ("variable", "looping", "array/list" campur), CI gagal. Ini murah dan mencegah inkonsistensi 50 bab.

### 4.5 Template bab (baku, jangan diimprovisasi tiap bab)

1. **Hook** 2–4 kalimat: masalah nyata atau miskonsepsi yang dibongkar. Tanpa "Bab ini akan membahas…".
2. **Tujuan** satu baris: "Setelah bab ini, pembaca bisa …".
3. **Konsep** sesingkat mungkin, satu contoh kecil yang jalan.
4. **Bangun bertahap**: satu program yang tumbuh; setiap langkah = satu perubahan + satu output.
5. **Error-first**: sengaja salahkan kode, tampilkan pesan compiler asli, ajari **cara membaca pesan itu** (ini keterampilan paling berguna dan paling jarang diajarkan).
6. **Output nyata** dari eksekusi (blok `output`, bukan gambar).
7. **Latihan 3–5 soal** dengan gradasi: (a) ubah, (b) prediksi output, (c) tulis dari nol, (d) perbaiki kode rusak. Jawaban di lampiran, bukan di bawah soal.
8. **Ringkasan** 3–5 poin.
9. **Selanjutnya** satu tautan ke bab berikutnya yang relevan + 2–3 referensi resmi.

Panjang: **900–1.400 kata**, 10–15 menit baca. Satu bab = satu sesi duduk. Bab yang lebih panjang dipecah.

### 4.6 Definition of Done per bab

- [ ] Bisa dibaca mandiri tanpa bab sebelumnya (kecuali istilah yang sudah didefinisikan).
- [ ] Semua snippet ada di `examples/` dan **lolos** `nim c -r` + cek output di CI.
- [ ] Minimal satu error sengaja + cara membacanya.
- [ ] Ada latihan + jawaban.
- [ ] Tidak ada istilah di luar glosarium tanpa definisi.
- [ ] Tangkapan layar (kalau ada) punya alt text.
- [ ] Terbaca di layar 390 px (HP) tanpa scroll horizontal kecuali blok kode.
- [ ] Cetak hitam-putih masih terbaca (callout, tabel).
- [ ] Link internal valid (`quarto` gagal kalau ada tautan mati dengan `--check-links`).

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
| Rollback | diganti **symlink swap**: `releases/<sha>/` + `current` → `previous` |
| Health gate | versi ringan: `curl -fsS` + cek halaman memuat judul + jumlah bab |
| Retensi | **3 rilis terakhir**, sisanya dihapus (padanan anti-disk-bloat) |

### Pilihan hosting

| Opsi | Biaya | Kontrol | Preview per PR | Catatan |
|---|---|---|---|---|
| **VPS + Caddy** (rekomendasi) | 0 (sudah ada) | penuh (header, cache, redirect) | opsional | `nim.qouver.com`; pola sama dengan `skyward`/`sds` yang memang menyajikan `root * /srv/qouver/apps/<app>/web` |
| GitHub Pages | 0 | rendah (header terbatas) | tidak | paling cepat jadi; domain `github.io` kurang untuk branding, tapi custom domain bisa |
| Cloudflare Pages | 0 | sedang | ya | CDN global + preview per PR; tapi keluar dari infra sendiri dan menambah satu dashboard lagi |

**Rekomendasi:** VPS, subdomain `nim.qouver.com`, **build di GitHub Actions** (bukan di VPS), VPS hanya menerima hasil.

Kenapa build di CI, bukan di VPS seperti `skyward`/`sds`:

- VPS tidak perlu Node 24 + Quarto + Typst (~350 MB) hanya untuk merender dokumentasi.
- Build deterministik: versi Nim, Quarto, dan font dipin di CI.
- **PDF dihasilkan dari build yang sama** dan ditempel ke GitHub Releases saat tag `v*`, tidak pernah menyentuh VPS.

Alur:

```
push ke main
  └─ CI: verify examples (nim c -r + golden output) → quarto render (html + pdf) → artifact
       └─ deploy-static.sh (di VPS, dipanggil webhook):
            ref-guard → flock → rsync artifact ke releases/<sha>/ → health check → swap symlink → prune
tag v*
  └─ CI: render ulang dengan nomor versi → upload PDF ke GitHub Releases
```

Catatan DNS & server (sudah dicocokkan dengan catatan server di `vps/SERVER_STATE.md`):

- Record: `A nim → 43.133.148.19`, **proxied (orange)** seperti 7 nama lain; SSL mode Cloudflare sudah `Full (strict)`.
- Karena proxied, origin wajib punya sertifikat valid untuk `nim.qouver.com`; Caddy menerbitkannya otomatis (HTTP-01, port 80 tetap terbuka ke Cloudflare).
- Path baru `/srv/qouver/apps/nim-id/web` butuh aturan `semanage fcontext` + `restorecon` **sekali** (sama seperti `kran`/`sds`). Tanpa itu Caddy balas 403/404 meski file ada.
- Sebelum blok Caddy ada, `nim.qouver.com` menjawab **525** (Cloudflare gagal handshake TLS ke origin karena Caddy belum punya vhost untuk SNI itu). Itu normal, bukan tanda DNS salah.

Script deploy static: ~60 baris bash, tanpa podman. Tetap `ops/scripts/deploy-static.sh`, tetap `ops/caddy/Caddyfile.nim-id.example`, tetap hook webhook HMAC, jadi masih "lewat infra", tapi dengan kontrak yang sesuai ukuran masalahnya.

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
├── examples/
│   └── variables/             # satu folder per bab, dipakai kedua bahasa
│       ├── a01_declaration.nim
│       ├── a01_declaration.expected
│       └── a03_immutable_error.expected-error
├── assets/ku.css              # sumber tunggal CSS; disalin ke tiap buku saat build
├── tools/
│   ├── verify-examples.sh
│   └── build-site.sh          # render keduanya → public/ dan public/en/
├── docs/                      # plan, writing-guide, glossary, deploy-vps
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

- **Nama berkas sama di kedua bahasa** (`chapters/variables.qmd`), supaya tautan silang dan
  penomoran tetap sinkron.
- **Kode contoh ditulis Inggris dan dipakai bersama.** Satu `examples/`, satu verifikasi, satu
  sumber kebenaran. Yang diterjemahkan hanya prosa.
- `tools/build-site.sh` merender kedua project lalu menyatukannya ke `public/`; deploy hanya
  menyentuh `public/`.
- CSS bersama di `assets/ku.css` disalin ke tiap project saat build (Quarto tidak menyalin berkas
  di luar direktori project, dan symlink tidak diikuti). Salinan tidak di-commit.
- Tanpa plugin i18n pihak ketiga (Babelquarto dan sejenisnya): menambah toolchain R tanpa manfaat
  sepadan.

---

## 7. Kerangka bab (~44 bab + lampiran)

**Bagian 0, Mulai (3):** Apa itu Nim dan kenapa; Instalasi (choosenim/brew, Termux); Alur kerja: `nim c -r`, `nimble`, editor + nimsuggest.

**Bagian A, Dasar (13):** Komentar & doc comment; Variabel `var`/`let`/`const`; Tipe dasar & literal; String & raw string; `echo` & format; Operator; `if`/`case`/`when`; Perulangan; `array` vs `seq` vs `openArray`; Tuple; Object; Enum & set; `proc`, parameter, nilai balik.

**Bagian B, Menengah (17):** Module & `import`/`export`; Exception & `raises`; Iterator & `yield`; Closure; Generic; Template; Macro; Concept; Object variant & `distinct`; `ref`/`ptr`/`nil`; ARC/ORC & `=destroy`; Tur pustaka standar (`strutils`, `sequtils`, `tables`, `json`); File & OS; `unittest`; `async`/`await`; FFI ke C; compile ke JS.

**Bagian C, Praktik (7):** CLI dengan `cligen`; HTTP API (mummy/jester); Database (`norm`); Membuat & menerbitkan paket nimble; Benchmark & profiling; Cross-compile & deploy biner; Proyek akhir.

**Bagian D, Lampiran (4):** Jawaban latihan; Glosarium; Cheat sheet; Nim untuk programmer Python/Go/Rust.

Bab yang **tidak** diambil dari buku Rust karena khas Rust: ownership, borrowing, lifetime, `use`/`path-item`, operator `?`, slice memory management.

---

## 8. Milestone

| Tahap | Isi | Estimasi | Gate |
|---|---|---|---|
| **M0** vertical slice | Skeleton repo, `_quarto.yml`, CI verify 3 snippet, **1 bab utuh** (Variabel), web + PDF 20 halaman, deploy `nim.qouver.com` | 2–3 hari | Baca di HP; cetak hitam-putih; highlight Nim tampil; PDF < 8 MB |
| **M1** fondasi | Bagian 0 + A (16 bab), glosarium 60 istilah, latihan + jawaban | 2–3 minggu | 16 bab DoD lengkap, CI hijau |
| **M2** menengah | Bagian B (17 bab) | 4–6 minggu | sama |
| **M3** praktik & rilis | Bagian C + D, polish PDF, tag `v1.0.0` | 3–4 minggu | PDF rilis + web stabil |

Total realistis **3–4 bulan** kerja konsisten. Publikasi per bab sejak M1; jangan menunggu M3.

---

## 9. Risiko

| Risiko | Mitigasi |
|---|---|
| Typst book Typst book masih muda | Sudah terbukti jalan di 1.10.19 (§2); escape hatch ke LaTeX dari sumber sama |
| Highlighting Nim | Terverifikasi didukung (§2); tidak perlu mitigasi |
| Istilah & ejaan melenceng antar bab | `docs/glossary.md` + lint CI untuk varian terlarang |
| Snippet basi saat Nim naik versi | Versi Nim dipin di CI, golden output memaksa snippet diperbarui saat upgrade |
| SEO: "NIM" = nomor induk mahasiswa | Selalu tulis "bahasa Nim" di judul/deskripsi, slug `belajar-nim`, structured data, judul buku eksplisit |
| Solo, 44 bab | 3 bab/minggu, terbit bertahap, tiap bab satu PR kecil |
| PDF membengkak | Tanpa screenshot besar; gambar SVG; target < 8 MB dicek di CI |

---

## 10. Keputusan

Sudah dikunci (23 Okt 2026):

1. **Nama repo `nim-id`.** Alasan: nama repo tidak memengaruhi SEO (situs ada di domain sendiri). `dasarpemrogramannim` ambigu dengan "NIM = nomor induk mahasiswa", dan `nim-id` bisa menampung glosarium/kurikulum/playground tanpa mengunci diri jadi satu buku.
2. **Domain `nim.qouver.com`** (pemilik menyiapkan record-nya).
3. **Judul buku terpisah dari nama repo**: "Dasar Pemrograman Nim: Bahasa Indonesia". Judul inilah yang jadi `<title>`, H1, dan slug halaman.
4. **Lisensi**: teks CC BY-SA 4.0 + kode contoh MIT.

Masih terbuka:

5. **Izin M0** (membuat repo + blok Caddy + deploy pertama).

Nama folder kerja sudah ikut diganti: `~/Projects/nim-book` → `~/Projects/nim-id`.

---

## 11. Status M0 (23 Okt 2026)

Sudah ada di `~/Projects/nim-id`:

- Quarto 1.10.19 di `~/.local/opt` (tanpa sudo) dan Nim 2.2.12.
- Satu bab utuh (Variabel) + 8 contoh yang dikompilasi dan diverifikasi: `bash tools/verify-examples.sh` → `8 lulus, 0 gagal`.
- Render web + PDF dari satu sumber. PDF 13 halaman, 197 KB.
- Kerangka CI, blok Caddy, `deploy-static.sh`, glosarium, pedoman penulisan, jawaban latihan.
- VPS: direktori `/srv/qouver/apps/nim-id/` + placeholder satu halaman sudah terpasang
  (`web -> releases/placeholder`), Quarto 1.10.19 ada di `.tools/quarto`. Blok Caddy belum,
  karena butuh `sudo`; blok siap tempel ada di `/srv/qouver/apps/nim-id/Caddyfile.nim-id.block`.

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

Sisa:

- [x] Deploy otomatis lewat webhook: repo GitHub `nferdazel/nim-id` (publik), hook `nim-id` di
      `/srv/qouver/config/webhook.json` (HMAC-SHA256), `monorepo/` di server, health check ke
      origin langsung dengan retry (bukan lewat Cloudflare).
- [x] Trim PDF 178 × 233 mm + label Indonesia ("Daftar Isi", "Lampiran"). Margin 16 × 18 mm,
      ukuran huruf 10 pt, diatur di `assets/typst/typst-show.typ`.
- [ ] CI pertama kali harus dijalankan di GitHub untuk memvalidasi aksi `setup-nim`/`quarto-actions`.
