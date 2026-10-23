# Glossary

Satu istilah, satu penulisan, satu definisi, untuk kedua bahasa. Tambahkan istilah di sini
**sebelum** dipakai di bab.

Kolom **English** dipakai versi Inggris. Istilah yang sudah baku di bahasa Inggris tidak
diterjemahkan ke bahasa Indonesia secara paksa; kolom **Jangan** mencatat varian yang dilarang.

| Istilah | English | Definisi | Jangan | Bab |
| --- | --- | --- | --- | --- |
| compiler | compiler | program yang menerjemahkan kode sumber menjadi biner | kompiler, pengompilasi | variables |
| compile-time | compile time | saat compile berlangsung; sebelum program berjalan | waktu kompilasi (kecuali penjelasan) | variables |
| runtime | runtime | saat program berjalan | waktu jalan | variables |
| value | value | isi yang disimpan variable | nilai | variables |
| variable | variable | nama untuk sebuah value | variable, peubah | variables |
| constant | constant | value yang tidak berubah | konstanta | variables |
| data type | data type | jenis value; menentukan operasi yang sah dan ukuran di memori | type data | variables |
| deklarasi | declaration | statement yang memperkenalkan nama baru | pendeklarasian (kata benda) | variables |
| inisialisasi | initialization | pengisian value pertama | penginitialisasian | variables |
| interpolasi string | string interpolation | menyisipkan value ke dalam teks | — | variables |
| identifier | identifier | nama untuk variable, type, procedure, atau module | pengenal | variables |
| pesan error | error message | keluaran compiler yang menjelaskan masalah | error message | variables |
| procedure | procedure | rutin yang bisa punya side effect (`proc`) | prosedur | — |
| fungsi | function | rutin tanpa side effect (`func`) | function | — |
| loop | loop | konstruksi untuk mengulang blok kode | looping, perulangan | — |
| percabangan | branching | pemilihan path eksekusi (`if`, `case`, `when`) | branching | — |
| array | array | kumpulan element bertipe sama, ukuran tetap | larik | — |
| seq | sequence | kumpulan element bertipe sama, ukuran dinamis (`seq`) | sequence (kecuali penjelasan awal) | — |
| object | object | type gabungan dengan field bernama | objek | — |
| exception | exception | kondisi error yang bisa ditangkap | pengecualian | — |
| iterator | iterator | konstruksi yang menghasilkan value satu per satu (`yield`) | — | loops |
| range | range | batas value dari awal sampai akhir (`a..b`, `a..<b`) | range (kecuali di kode) | loops |
| index | index | posisi element di dalam koleksi, mulai dari 0 | indeks | collections |
| element | element | satu value di dalam koleksi | elemen | collections |
| literal | literal | value yang ditulis langsung di kode (`42`, `"teks"`, `@[1, 2]`) | — | primitive-types |
| expression | expression | rangkaian kode yang menghasilkan value | ekspresi | conditionals |
| statement | statement | satuan kode yang melakukan sesuatu, tidak selalu menghasilkan value | pernyataan | conditionals |
| parameter | parameter | nama value yang diterima procedure | argument (untuk isi pemanggilan) | procedures |
| default value | default value | value yang dipakai kalau argumen tidak diberikan | nilai default | procedures |
| inklusif | inclusive | batas akhir ikut dihitung (`0..5` berisi 5) | — | loops |
| eksklusif | exclusive | batas akhir tidak ikut dihitung (`0..<5` berhenti di 4) | — | loops |
| ordinal type | ordinal type | type yang value itu bisa diurutkan dan dihitung (`int`, `char`, `enum`) | tipe ordinal | enums-and-sets |
| stack trace | stack trace | daftar pemanggilan yang ditampilkan saat program berhenti karena defect atau exception yang tidak tertangani | jejak tumpukan | collections |
| biner | binary | file hasil compile yang bisa dijalankan mesin | binary | what-is-nim |
| mesin virtual | virtual machine | lapisan perangkat lunak yang menjalankan kode di atas CPU | VM | what-is-nim |
| backend | backend | target keluaran compiler (C, C++, JavaScript) | back-end | what-is-nim |
| debug build | debug build | build dengan pemeriksaan penuh, dipakai saat mengembangkan | build debug | workflow |
| release build | release build | build teroptimasi, dipakai saat mengirim program | build rilis | workflow |
| garbage collector | garbage collector | pengelola memori otomatis pada mode GC klasik | pemungut sampah | what-is-nim |
| destructor | destructor | procedure `=destroy` yang dipanggil saat value dibuang | destructor (kecuali penjelasan) | what-is-nim |
| scope | scope | wilayah kode tempat sebuah nama bisa dipakai | scope (kecuali penjelasan) | comments |
| komentar baris | line comment | komentar `#` sampai akhir baris | komentar satu baris | comments |
| komentar blok | block comment | komentar `#[ ... ]#` yang bisa bersarang | komentar multi-baris | comments |
| doc comment | doc comment | komentar `##` yang terbaca oleh `nim doc` | dokumentasi komentar | comments |
| package manager | package manager | tool yang memasang dan mengelola dependensi (`nimble`) | pengelola paket | installation |
| standard library | standard library | kumpulan module bawaan compiler | library standar | installation |
| scaffold | project scaffold | kerangka file yang dibuat `nimble init` | scaffolding | installation |
| escape sequence | escape sequence | pasangan `\` + huruf yang mewakili character khusus (`\n`, `\t`) | escape sequence | strings |
| raw string | raw string | string `r"..."` yang tidak memproses escape | string mentah | strings |
| string multi-baris | multiline string | string `"""..."""` yang mempertahankan baris baru | string multiline | strings |
| slicing | slicing | mengambil potongan string/koleksi dengan range index | — | strings |
| overflow | overflow | value yang melewati batas type dan berakhir `OverflowDefect` | luapan | primitive-types |
| short-circuit | short-circuit evaluation | `and`/`or` berhenti begitu hasilnya pasti | evaluasi singkat | operators |
| bitwise | bitwise | operasi per bit (`and`, `or`, `xor`, `shl`, `shr`) | bitwise | operators |
| keanggotaan | membership | uji `in`/`notin` pada koleksi atau range | — | operators |
| presisi | precision | jumlah digit signifikan yang dijamin type float | — | primitive-types |
| type conversion | type conversion | mengubah value ke type lain (`int()`, `float()`, `$`) | casting (hindari) | primitive-types |
| baris baru | newline | character `\n` yang memindahkan keluaran ke baris berikutnya | newline | printing |
| tuple | tuple | kumpulan value bertipe berbeda dengan urutan tetap | — | tuples |
| destructuring | destructuring | membongkar tuple menjadi variable terpisah | unpacking (kecuali penyebutan) | tuples |
| enum | enum | type dengan daftar value bernama yang sudah pasti | enumerasi | enums-and-sets |
| set | set | kumpulan value berbeda dari type ordinal (`set[Color]`) | himpunan | enums-and-sets |
| ordinal value | ordinal value | posisi angka sebuah value enum (`ord(green)`) | nilai ordinal | enums-and-sets |
| bitset | bitset | set yang disimpan sebagai bit, dipakai untuk flag | himpunan bit | enums-and-sets |
| constructor | constructor | expression yang membentuk value object (`Person(name: ...)`) | constructor (kecuali di kode) | objects |
| overloading | overloading | beberapa procedure bernama sama dengan daftar parameter berbeda | overload | procedures |
| return value | return value | value yang dikembalikan procedure | nilai kembalian, nilai balik | procedures |
| side effect | side effect | perubahan di luar return value (`echo`, menulis file, mengubah `var`) | efek samping | procedures |
| argumen bernama | named argument | argumen yang ditulis bersama nama parameternya | — | procedures |
| referensi | reference | value yang menunjuk object di heap (`ref object`) | reference | objects |
| value copy | value copy | penyalinan isi value, bukan alamatnya | salinan nilai | objects |
| closure | closure | procedure yang membawa variable di sekitarnya | — | closures |
| anonymous procedure | anonymous procedure | procedure tanpa nama yang dipakai sebagai value | prosedur anonim | closures |
| menangkap | capture | closure memakai variable dari scope luar | — | closures |
| konvensi pemanggilan | calling convention | aturan cara procedure dipanggil (`nimcall`, `closure`) | — | closures |
| higienis | hygienic | makro atau template yang tidak membocorkan nama ke pemanggil | higienis (kecuali sebagai sifat) | templates |
| ekspansi template | template expansion | kode template yang disalin compiler ke tempat pemanggilan | — | templates |
| instansiasi generic | generic instantiation | pembentukan type konkret dari generic pada pemakaian | — | generics |
| typedesc | typedesc | type sebagai value, dipakai untuk overloading berbasis type | — | generics |
| pointer | pointer | value yang menyimpan alamat memori (`ptr`) | penunjuk | refs-and-pointers |
| alamat | address | lokasi value di memori, diperoleh lewat `addr` | — | refs-and-pointers |
| dereferensi | dereference | mengambil value yang ditunjuk sebuah pointer | — | refs-and-pointers |
| penghitungan referensi | reference counting | menghitung pemakai sebuah value untuk tahu kapan dibebaskan | ref counting | memory-management |
| mode memori | memory management mode | pilihan pengelola memori compiler (`--mm:arc`, `--mm:orc`) | — | memory-management |
| sumber daya | resource | hal yang harus dibebaskan setelah dipakai (file, socket) | resource | files-and-os |
| module | module | file atau folder yang berisi kode dan bisa diimpor | modul | modules |
| ruang nama | namespace | wilayah nama yang dipisahkan module | namespace | modules |
| mengimpor | import | memakai isi module lain | impor (kecuali di kode) | modules |
| mengekspor | export | menandai simbol module yang boleh dipakai dari luar | ekspor (verba) | modules |
| effect | effect | sifat procedure yang dapat diperiksa compiler (`raises`) | efek | exceptions |
| fasad | facade | module tipis yang menyatukan beberapa module lain | facade | modules |
| macro | macro | procedure compile-time yang menerima dan menghasilkan AST | — | macros |
| pohon sintaksis | abstract syntax tree | struktur pohon yang mewakili kode sumber | AST (kecuali penjelasan awal) | macros |
| `quote do` | quote do | blok macro yang menulis kode seperti biasa | — | macros |
| untyped | untyped | parameter macro yang diterima sebelum diperiksa type | — | macros |
| konsep | concept | syarat bentuk type yang diperiksa saat overloading | concept (kecuali di kode) | concepts |
| variant object | variant object | object yang field-nya bergantung pada satu penanda | — | variants-and-distinct |
| distinct | distinct | type baru dengan representasi sama tetapi tidak saling tukar | — | variants-and-distinct |
| type alias | type alias | nama lain untuk type yang sudah ada, tanpa type baru | — | variants-and-distinct |
| file | file | satuan penyimpanan di sistem file | berkas | files-and-os |
| directory | directory | wadah file dan directory lain | folder (kecuali sehari-hari) | files-and-os |
| path | path | lokasi file dalam sistem file | jalur | files-and-os |
| environment variable | environment variable | value konfigurasi dari proses induk | env var | files-and-os |
| thread | thread | path eksekusi di dalam satu proses | utas | async |
| event loop | event loop | pengatur tugas async dalam satu thread | putaran peristiwa | async |
| suite | suite | kumpulan test dalam `unittest` | — | unit-testing |
| test case | test case | satu pemeriksaan di dalam suite | kasus uji | unit-testing |
| FFI | foreign function interface | cara memanggil kode bahasa lain, di sini C | — | ffi-c |
| ABI | application binary interface | aturan tata letak dan pemanggilan di tingkat biner | — | ffi-c |
| browser | browser | program yang menjalankan hasil compile JavaScript | browser (kecuali di kode) | js-backend |
| subcommand | subcommand | command kedua di dalam satu tool CLI (`tool add`) | subperintah | cli-tools |
| option | option | argumen bernama yang mengubah perilaku command (`--count=4`) | opsi | cli-tools |
| exit code | exit code | angka yang dikembalikan proses ke pemanggilnya | exit status | cli-tools |
| entry point | entry point | file atau procedure pertama yang dijalankan | pintu masuk | cli-tools |
| route | route | pemetaan path dan metode HTTP ke handler | rute | http-api |
| handler | handler | fungsi yang menangani satu permintaan atau peristiwa | pengendali | http-api |
| socket | socket | ujung koneksi jaringan yang dipakai server dan klien | soket | http-api |
| row | row | satu catatan di dalam tabel atau hasil query | baris | database |
| query | query | permintaan data ke basis data | kueri | database |
| transaction | transaction | rangkaian perubahan yang harus berhasil semua atau tidak sama sekali | transaksi | database |
| package | package | satuan distribusi kode yang bisa dipasang | paket | nimble-packages |
| maintainer | maintainer | orang yang bertanggung jawab merawat sebuah package | pemelihara | nimble-packages |
| warning | warning | pesan compiler tentang kode yang patut diperiksa | peringatan | workflow |
| test | test | pemeriksaan otomatis terhadap perilaku kode | tes | unit-testing |
| release | release | versi yang diterbitkan dan diberi tag | rilis | workflow |
| endpoint | endpoint | alamat dan metode yang dilayani sebuah API | titik akhir | http-api |
Aturan singkat:

- Istilah di kolom pertama dipakai di teks Indonesia; kolom English di teks Inggris.
- Nama tipe dan kata kunci selalu dalam bentuk kode: `array`, `seq`, `object`, `var`.
- Istilah asing yang belum ada padanan bakunya dicetak *miring*: *closure*, *iterator*, *macro*,
  *template*, *pragma*, *generic*.
- Identifier, komentar, dan string di `examples/` selalu bahasa Inggris, apa pun bahasanya buku.
