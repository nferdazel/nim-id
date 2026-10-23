# Glossary

Satu istilah, satu penulisan, satu definisi, untuk kedua bahasa. Tambahkan istilah di sini
**sebelum** dipakai di bab.

Kolom **English** dipakai versi Inggris. Istilah yang sudah baku di bahasa Inggris tidak
diterjemahkan ke bahasa Indonesia secara paksa; kolom **Jangan** mencatat varian yang dilarang.

| Istilah | English | Definisi | Jangan | Bab |
|---|---|---|---|---|
| compiler | compiler | program yang menerjemahkan kode sumber menjadi biner | kompiler, pengompilasi | variables |
| compile-time | compile time | saat kompilasi berlangsung; sebelum program berjalan | waktu kompilasi (kecuali penjelasan) | variables |
| runtime | runtime | saat program berjalan | waktu jalan | variables |
| nilai | value | isi yang disimpan variabel | value | variables |
| variabel | variable | nama untuk sebuah nilai | variable, peubah | variables |
| konstanta | constant | nilai yang tidak berubah | constant | variables |
| tipe data | data type | jenis nilai; menentukan operasi yang sah dan ukuran di memori | type data | variables |
| deklarasi | declaration | pernyataan yang memperkenalkan nama baru | pendeklarasian (kata benda) | variables |
| inisialisasi | initialization | pengisian nilai pertama | penginitialisasian | variables |
| interpolasi string | string interpolation | menyisipkan nilai ke dalam teks | — | variables |
| identifier | identifier | nama untuk variabel, tipe, prosedur, atau modul | pengenal | variables |
| pesan error | error message | keluaran compiler yang menjelaskan masalah | error message | variables |
| prosedur | procedure | rutin yang bisa punya efek samping (`proc`) | procedure | — |
| fungsi | function | rutin tanpa efek samping (`func`) | function | — |
| perulangan | loop | konstruksi untuk mengulang blok kode | looping, loop (kecuali di kode) | — |
| percabangan | branching | pemilihan jalur eksekusi (`if`, `case`, `when`) | branching | — |
| larik | array | kumpulan elemen bertipe sama, ukuran tetap | array (pakai `array` hanya saat merujuk tipe) | — |
| barisan | sequence | kumpulan elemen bertipe sama, ukuran dinamis (`seq`) | sequence (kecuali penjelasan awal) | — |
| objek | object | tipe gabungan dengan field bernama | object (kecuali saat merujuk kata kunci) | — |
| pengecualian | exception | kondisi error yang bisa ditangkap | exception | — |

| iterator | iterator | objek yang menghasilkan nilai satu per satu (`yield`) | — | loops |
| rentang | range | batas nilai dari awal sampai akhir (`a..b`, `a..<b`) | range (kecuali di kode) | loops |
| indeks | index | posisi elemen di dalam koleksi, mulai dari 0 | index | collections |
| elemen | element | satu nilai di dalam koleksi | element | collections |
| literal | literal | nilai yang ditulis langsung di kode (`42`, `"teks"`, `@[1, 2]`) | — | primitive-types |
| ekspresi | expression | rangkaian kode yang menghasilkan nilai | expression | conditionals |
| pernyataan | statement | satuan kode yang melakukan sesuatu, tidak selalu menghasilkan nilai | statement | conditionals |
| parameter | parameter | nama nilai yang diterima prosedur | argument (untuk isi pemanggilan) | procedures |
| nilai default | default value | nilai yang dipakai kalau argumen tidak diberikan | — | procedures |
| inklusif | inclusive | batas akhir ikut dihitung (`0..5` berisi 5) | — | loops |
| eksklusif | exclusive | batas akhir tidak ikut dihitung (`0..<5` berhenti di 4) | — | loops |
| tipe ordinal | ordinal type | tipe yang nilainya bisa diurutkan dan dihitung (`int`, `char`, `enum`) | — | enums-and-sets |
| jejak tumpukan | stack trace | daftar pemanggilan yang ditampilkan saat program berhenti karena defect | — | collections |

| biner | binary | berkas hasil kompilasi yang bisa dijalankan mesin | binary | what-is-nim |
| mesin virtual | virtual machine | lapisan perangkat lunak yang menjalankan kode di atas CPU | VM | what-is-nim |
| backend | backend | target keluaran compiler (C, C++, JavaScript) | back-end | what-is-nim |
| debug build | debug build | build dengan pemeriksaan penuh, dipakai saat mengembangkan | build debug | workflow |
| release build | release build | build teroptimasi, dipakai saat mengirim program | build rilis | workflow |
| garbage collector | garbage collector | pengelola memori otomatis pada mode GC klasik | pemungut sampah | what-is-nim |
| destruktor | destructor | prosedur `=destroy` yang dipanggil saat nilai dibuang | destructor (kecuali penjelasan) | what-is-nim |
| ruang lingkup | scope | wilayah kode tempat sebuah nama bisa dipakai | scope (kecuali penjelasan) | comments |
| komentar baris | line comment | komentar `#` sampai akhir baris | komentar satu baris | comments |
| komentar blok | block comment | komentar `#[ ... ]#` yang bisa bersarang | komentar multi-baris | comments |
| doc comment | doc comment | komentar `##` yang terbaca oleh `nim doc` | dokumentasi komentar | comments |
| pengelola paket | package manager | alat yang memasang dan mengelola dependensi (`nimble`) | manajer paket | installation |
| pustaka standar | standard library | kumpulan modul bawaan compiler | library standar | installation |
| perancah proyek | project scaffold | kerangka berkas yang dibuat `nimble init` | scaffolding | installation |

| escape sequence | escape sequence | pasangan `\` + huruf yang mewakili karakter khusus (`\n`, `\t`) | escape sequence | strings |
| raw string | raw string | string `r"..."` yang tidak memproses escape | string mentah | strings |
| string multi-baris | multiline string | string `"""..."""` yang mempertahankan baris baru | string multiline | strings |
| slicing | slicing | mengambil potongan string/koleksi dengan rentang indeks | — | strings |
| overflow | overflow | nilai yang melewati batas tipe dan berakhir `OverflowDefect` | luapan | primitive-types |
| evaluasi singkat | short-circuit evaluation | `and`/`or` berhenti begitu hasilnya pasti | short-circuit | operators |
| bitwise | bitwise | operasi per bit (`and`, `or`, `xor`, `shl`, `shr`) | bitwise | operators |
| keanggotaan | membership | uji `in`/`notin` pada koleksi atau rentang | — | operators |
| presisi | precision | jumlah digit signifikan yang dijamin tipe float | — | primitive-types |
| konversi tipe | type conversion | mengubah nilai ke tipe lain (`int()`, `float()`, `$`) | casting (hindari) | primitive-types |
| baris baru | newline | karakter `\n` yang memindahkan keluaran ke baris berikutnya | newline | printing |

| tuple | tuple | kumpulan nilai bertipe berbeda dengan urutan tetap | — | tuples |
| destructuring | destructuring | membongkar tuple menjadi variabel terpisah | unpacking (kecuali penyebutan) | tuples |
| enum | enum | tipe dengan daftar nilai bernama yang sudah pasti | enumerasi | enums-and-sets |
| himpunan | set | kumpulan nilai berbeda dari tipe ordinal (`set[Color]`) | set (kecuali di kode) | enums-and-sets |
| nilai ordinal | ordinal value | posisi angka sebuah nilai enum (`ord(green)`) | — | enums-and-sets |
| himpunan bit | bitset | himpunan yang disimpan sebagai bit, dipakai untuk flag | — | enums-and-sets |
| konstruktor | constructor | ekspresi yang membentuk nilai object (`Person(name: ...)`) | constructor (kecuali di kode) | objects |
| overloading | overloading | beberapa prosedur bernama sama dengan daftar parameter berbeda | overload | procedures |
| nilai balik | return value | nilai yang dikembalikan prosedur | nilai kembalian, return value | procedures |
| efek samping | side effect | perubahan di luar nilai balik (`echo`, menulis berkas, mengubah `var`) | — | procedures |
| argumen bernama | named argument | argumen yang ditulis bersama nama parameternya | — | procedures |
| referensi | reference | nilai yang menunjuk object di heap (`ref object`) | reference | objects |
| salinan nilai | value copy | penyalinan isi nilai, bukan alamatnya | — | objects |

| closure | closure | prosedur yang membawa variabel di sekitarnya | — | closures |
| prosedur anonim | anonymous procedure | prosedur tanpa nama yang dipakai sebagai nilai | — | closures |
| menangkap | capture | closure memakai variabel dari ruang lingkup luar | — | closures |
| konvensi pemanggilan | calling convention | aturan cara prosedur dipanggil (`nimcall`, `closure`) | — | closures |
| higienis | hygienic | makro atau template yang tidak membocorkan nama ke pemanggil | higienis (kecuali sebagai sifat) | templates |
| ekspansi template | template expansion | kode template yang disalin compiler ke tempat pemanggilan | — | templates |
| instansiasi generic | generic instantiation | pembentukan tipe konkret dari generic pada pemakaian | — | generics |
| typedesc | typedesc | tipe sebagai nilai, dipakai untuk overloading berbasis tipe | — | generics |

| penunjuk | pointer | nilai yang menyimpan alamat memori (`ptr`) | pointer (kecuali di kode) | refs-and-pointers |
| alamat | address | lokasi nilai di memori, diperoleh lewat `addr` | — | refs-and-pointers |
| dereferensi | dereference | mengambil nilai yang ditunjuk sebuah penunjuk | — | refs-and-pointers |
| penghitungan referensi | reference counting | menghitung pemakai sebuah nilai untuk tahu kapan dibebaskan | ref counting | memory-management |
| mode memori | memory management mode | pilihan pengelola memori compiler (`--mm:arc`, `--mm:orc`) | — | memory-management |
| sumber daya | resource | hal yang harus dibebaskan setelah dipakai (berkas, soket) | resource | files-and-os |

| modul | module | berkas atau folder yang berisi kode dan bisa diimpor | module | modules |
| ruang nama | namespace | wilayah nama yang dipisahkan modul | namespace | modules |
| mengimpor | import | memakai isi modul lain | impor (kecuali di kode) | modules |
| mengekspor | export | menandai simbol modul yang boleh dipakai dari luar | ekspor (verba) | modules |
| efek | effect | sifat prosedur yang dapat diperiksa compiler (`raises`) | — | exceptions |
| fasad | facade | modul tipis yang menyatukan beberapa modul lain | facade | modules |

Aturan singkat:

- Istilah di kolom pertama dipakai di teks Indonesia; kolom English di teks Inggris.
- Nama tipe dan kata kunci selalu dalam bentuk kode: `array`, `seq`, `object`, `var`.
- Istilah asing yang belum ada padanan bakunya dicetak *miring*: *closure*, *iterator*, *macro*,
  *template*, *pragma*, *generic*.
- Identifier, komentar, dan string di `examples/` selalu bahasa Inggris, apa pun bahasanya buku.
