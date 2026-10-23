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
| nilai | value | isi yang disimpan variabel | value | variables |
| variabel | variable | nama untuk sebuah nilai | variable, peubah | variables |
| konstanta | constant | nilai yang tidak berubah | constant | variables |
| tipe data | data type | jenis nilai; menentukan operasi yang sah dan ukuran di memori | type data | variables |
| deklarasi | declaration | statement yang memperkenalkan nama baru | pendeklarasian (kata benda) | variables |
| inisialisasi | initialization | pengisian nilai pertama | penginitialisasian | variables |
| interpolasi string | string interpolation | menyisipkan nilai ke dalam teks | — | variables |
| identifier | identifier | nama untuk variabel, tipe, procedure, atau modul | pengenal | variables |
| pesan error | error message | keluaran compiler yang menjelaskan masalah | error message | variables |
| procedure | procedure | rutin yang bisa punya efek samping (`proc`) | prosedur | — |
| fungsi | function | rutin tanpa efek samping (`func`) | function | — |
| loop | loop | konstruksi untuk mengulang blok kode | looping, loop (kecuali di kode) | — |
| percabangan | branching | pemilihan jalur eksekusi (`if`, `case`, `when`) | branching | — |
| array | array | kumpulan elemen bertipe sama, ukuran tetap | array (pakai `array` hanya saat merujuk tipe) | — |
| seq | sequence | kumpulan elemen bertipe sama, ukuran dinamis (`seq`) | sequence (kecuali penjelasan awal) | — |
| object | object | tipe gabungan dengan field bernama | object (kecuali saat merujuk kata kunci) | — |
| exception | exception | kondisi error yang bisa ditangkap | pengecualian | — |
| iterator | iterator | object yang menghasilkan nilai satu per satu (`yield`) | — | loops |
| rentang | range | batas nilai dari awal sampai akhir (`a..b`, `a..<b`) | range (kecuali di kode) | loops |
| indeks | index | posisi elemen di dalam koleksi, mulai dari 0 | index | collections |
| elemen | element | satu nilai di dalam koleksi | element | collections |
| literal | literal | nilai yang ditulis langsung di kode (`42`, `"teks"`, `@[1, 2]`) | — | primitive-types |
| expression | expression | rangkaian kode yang menghasilkan nilai | ekspresi | conditionals |
| statement | statement | satuan kode yang melakukan sesuatu, tidak selalu menghasilkan nilai | pernyataan | conditionals |
| parameter | parameter | nama nilai yang diterima procedure | argument (untuk isi pemanggilan) | procedures |
| nilai default | default value | nilai yang dipakai kalau argumen tidak diberikan | — | procedures |
| inklusif | inclusive | batas akhir ikut dihitung (`0..5` berisi 5) | — | loops |
| eksklusif | exclusive | batas akhir tidak ikut dihitung (`0..<5` berhenti di 4) | — | loops |
| tipe ordinal | ordinal type | tipe yang nilainya bisa diurutkan dan dihitung (`int`, `char`, `enum`) | — | enums-and-sets |
| stack trace | stack trace | daftar pemanggilan yang ditampilkan saat program berhenti karena defect | jejak tumpukan | collections |
| biner | binary | file hasil compile yang bisa dijalankan mesin | binary | what-is-nim |
| mesin virtual | virtual machine | lapisan perangkat lunak yang menjalankan kode di atas CPU | VM | what-is-nim |
| backend | backend | target keluaran compiler (C, C++, JavaScript) | back-end | what-is-nim |
| debug build | debug build | build dengan pemeriksaan penuh, dipakai saat mengembangkan | build debug | workflow |
| release build | release build | build teroptimasi, dipakai saat mengirim program | build rilis | workflow |
| garbage collector | garbage collector | pengelola memori otomatis pada mode GC klasik | pemungut sampah | what-is-nim |
| destruktor | destructor | procedure `=destroy` yang dipanggil saat nilai dibuang | destructor (kecuali penjelasan) | what-is-nim |
| scope | scope | wilayah kode tempat sebuah nama bisa dipakai | scope (kecuali penjelasan) | comments |
| komentar baris | line comment | komentar `#` sampai akhir baris | komentar satu baris | comments |
| komentar blok | block comment | komentar `#[ ... ]#` yang bisa bersarang | komentar multi-baris | comments |
| doc comment | doc comment | komentar `##` yang terbaca oleh `nim doc` | dokumentasi komentar | comments |
| package manager | package manager | alat yang memasang dan mengelola dependensi (`nimble`) | pengelola paket | installation |
| standard library | standard library | kumpulan modul bawaan compiler | library standar | installation |
| scaffold | project scaffold | kerangka file yang dibuat `nimble init` | scaffolding | installation |
| escape sequence | escape sequence | pasangan `\` + huruf yang mewakili karakter khusus (`\n`, `\t`) | escape sequence | strings |
| raw string | raw string | string `r"..."` yang tidak memproses escape | string mentah | strings |
| string multi-baris | multiline string | string `"""..."""` yang mempertahankan baris baru | string multiline | strings |
| slicing | slicing | mengambil potongan string/koleksi dengan rentang indeks | — | strings |
| overflow | overflow | nilai yang melewati batas tipe dan berakhir `OverflowDefect` | luapan | primitive-types |
| short-circuit | short-circuit evaluation | `and`/`or` berhenti begitu hasilnya pasti | evaluasi singkat | operators |
| bitwise | bitwise | operasi per bit (`and`, `or`, `xor`, `shl`, `shr`) | bitwise | operators |
| keanggotaan | membership | uji `in`/`notin` pada koleksi atau rentang | — | operators |
| presisi | precision | jumlah digit signifikan yang dijamin tipe float | — | primitive-types |
| konversi tipe | type conversion | mengubah nilai ke tipe lain (`int()`, `float()`, `$`) | casting (hindari) | primitive-types |
| baris baru | newline | karakter `\n` yang memindahkan keluaran ke baris berikutnya | newline | printing |
| tuple | tuple | kumpulan nilai bertipe berbeda dengan urutan tetap | — | tuples |
| destructuring | destructuring | membongkar tuple menjadi variabel terpisah | unpacking (kecuali penyebutan) | tuples |
| enum | enum | tipe dengan daftar nilai bernama yang sudah pasti | enumerasi | enums-and-sets |
| set | set | kumpulan nilai berbeda dari tipe ordinal (`set[Color]`) | set (kecuali di kode) | enums-and-sets |
| nilai ordinal | ordinal value | posisi angka sebuah nilai enum (`ord(green)`) | — | enums-and-sets |
| bitset | bitset | set yang disimpan sebagai bit, dipakai untuk flag | himpunan bit | enums-and-sets |
| konstruktor | constructor | expression yang membentuk nilai object (`Person(name: ...)`) | constructor (kecuali di kode) | objects |
| overloading | overloading | beberapa procedure bernama sama dengan daftar parameter berbeda | overload | procedures |
| return value | return value | nilai yang dikembalikan procedure | nilai kembalian, return value | procedures |
| efek samping | side effect | perubahan di luar return value (`echo`, menulis file, mengubah `var`) | — | procedures |
| argumen bernama | named argument | argumen yang ditulis bersama nama parameternya | — | procedures |
| referensi | reference | nilai yang menunjuk object di heap (`ref object`) | reference | objects |
| salinan nilai | value copy | penyalinan isi nilai, bukan alamatnya | — | objects |
| closure | closure | procedure yang membawa variabel di sekitarnya | — | closures |
| anonymous procedure | anonymous procedure | procedure tanpa nama yang dipakai sebagai nilai | prosedur anonim | closures |
| menangkap | capture | closure memakai variabel dari scope luar | — | closures |
| konvensi pemanggilan | calling convention | aturan cara procedure dipanggil (`nimcall`, `closure`) | — | closures |
| higienis | hygienic | makro atau template yang tidak membocorkan nama ke pemanggil | higienis (kecuali sebagai sifat) | templates |
| ekspansi template | template expansion | kode template yang disalin compiler ke tempat pemanggilan | — | templates |
| instansiasi generic | generic instantiation | pembentukan tipe konkret dari generic pada pemakaian | — | generics |
| typedesc | typedesc | tipe sebagai nilai, dipakai untuk overloading berbasis tipe | — | generics |
| pointer | pointer | nilai yang menyimpan alamat memori (`ptr`) | penunjuk | refs-and-pointers |
| alamat | address | lokasi nilai di memori, diperoleh lewat `addr` | — | refs-and-pointers |
| dereferensi | dereference | mengambil nilai yang ditunjuk sebuah pointer | — | refs-and-pointers |
| penghitungan referensi | reference counting | menghitung pemakai sebuah nilai untuk tahu kapan dibebaskan | ref counting | memory-management |
| mode memori | memory management mode | pilihan pengelola memori compiler (`--mm:arc`, `--mm:orc`) | — | memory-management |
| sumber daya | resource | hal yang harus dibebaskan setelah dipakai (file, socket) | resource | files-and-os |
| modul | module | file atau folder yang berisi kode dan bisa diimpor | module | modules |
| ruang nama | namespace | wilayah nama yang dipisahkan modul | namespace | modules |
| mengimpor | import | memakai isi modul lain | impor (kecuali di kode) | modules |
| mengekspor | export | menandai simbol modul yang boleh dipakai dari luar | ekspor (verba) | modules |
| efek | effect | sifat procedure yang dapat diperiksa compiler (`raises`) | — | exceptions |
| fasad | facade | modul tipis yang menyatukan beberapa modul lain | facade | modules |
| macro | macro | procedure compile-time yang menerima dan menghasilkan AST | — | macros |
| pohon sintaksis | abstract syntax tree | struktur pohon yang mewakili kode sumber | AST (kecuali penjelasan awal) | macros |
| `quote do` | quote do | blok macro yang menulis kode seperti biasa | — | macros |
| untyped | untyped | parameter macro yang diterima sebelum diperiksa tipe | — | macros |
| konsep | concept | syarat bentuk tipe yang diperiksa saat overloading | concept (kecuali di kode) | concepts |
| object varian | variant object | object yang field-nya bergantung pada satu penanda | — | variants-and-distinct |
| distinct | distinct | tipe baru dengan representasi sama tetapi tidak saling tukar | — | variants-and-distinct |
| alias tipe | type alias | nama lain untuk tipe yang sudah ada, tanpa tipe baru | — | variants-and-distinct |
| file | file | satuan penyimpanan di sistem file | berkas | files-and-os |
| direktori | directory | wadah file dan direktori lain | folder (kecuali sehari-hari) | files-and-os |
| jalur | path | lokasi file dalam sistem file | path | files-and-os |
| variabel lingkungan | environment variable | nilai konfigurasi dari proses induk | env var | files-and-os |
| thread | thread | jalur eksekusi di dalam satu proses | utas | async |
| event loop | event loop | pengatur tugas async dalam satu thread | putaran peristiwa | async |
| suite | suite | kumpulan test dalam `unittest` | — | unit-testing |
| test case | test case | satu pemeriksaan di dalam suite | kasus uji | unit-testing |
| FFI | foreign function interface | cara memanggil kode bahasa lain, di sini C | — | ffi-c |
| ABI | application binary interface | aturan tata letak dan pemanggilan di tingkat biner | — | ffi-c |
| peramban | browser | program yang menjalankan hasil compile JavaScript | browser (kecuali di kode) | js-backend |
| subperintah | subcommand | perintah kedua di dalam satu alat CLI (`tool add`) | — | cli-tools |
| opsi | option | argumen bernama yang mengubah perilaku perintah (`--count=4`) | — | cli-tools |
| kode keluar | exit code | angka yang dikembalikan proses ke pemanggilnya | exit status | cli-tools |
| pintu masuk | entry point | file atau procedure pertama yang dijalankan | entry point | cli-tools |
| rute | route | pemetaan jalur dan metode HTTP ke handler | — | http-api |
| handler | handler | fungsi yang menangani satu permintaan atau peristiwa | pengendali | http-api |
| socket | socket | ujung koneksi jaringan yang dipakai server dan klien | soket | http-api |
| baris | row | satu catatan di dalam tabel atau hasil query | — | database |
| query | query | permintaan data ke basis data | kueri | database |
| transaksi | transaction | rangkaian perubahan yang harus berhasil semua atau tidak sama sekali | — | database |
| package | package | satuan distribusi kode yang bisa dipasang | paket | nimble-packages |
| pemelihara | maintainer | orang yang bertanggung jawab merawat sebuah package | — | nimble-packages |
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
