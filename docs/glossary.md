# Glossary

Satu istilah, satu penulisan, satu definisi, untuk kedua bahasa. Tambahkan istilah di sini
**sebelum** dipakai di bab.

Kolom **English** dipakai versi Inggris. Istilah yang sudah baku di bahasa Inggris tidak
diterjemahkan ke bahasa Indonesia secara paksa; kolom **Jangan** mencatat varian yang dilarang.
Kolom **Definisi Inggris** dipakai halaman glosarium edisi English.

Setelah mengubah tabel ini, jalankan `python3 tools/gen-glossary.py` untuk membangun ulang
`books/{id,en}/appendix/glossary.qmd`, lalu `python3 tools/check-glossary-page.py`.

| Istilah | English | Definisi | Definisi Inggris | Jangan | Bab |
| --- | --- | --- | --- | --- | --- |
| compiler | compiler | program yang menerjemahkan kode sumber menjadi biner | a program that translates source code into a binary | kompiler, pengompilasi | variables |
| compile-time | compile time | saat compile berlangsung; sebelum program berjalan | while compilation runs; before the program starts | waktu kompilasi (kecuali penjelasan) | variables |
| runtime | runtime | saat program berjalan | while the program is running | waktu jalan | variables |
| value | value | isi yang disimpan variable | the content stored in a variable | nilai | variables |
| variable | variable | nama untuk sebuah value | a name for a value | variable, peubah | variables |
| constant | constant | value yang tidak berubah | a value that does not change | konstanta | variables |
| data type | data type | jenis value; menentukan operasi yang sah dan ukuran di memory | the kind of a value; it decides which operations are valid and how much memory it uses | type data | variables |
| type | type | bentuk pendek dari data type; dipakai di prosa dan kode | short for data type; used in prose and code | tipe | variables |
| deklarasi | declaration | statement yang memperkenalkan nama baru | a statement that introduces a new name | pendeklarasian (kata benda) | variables |
| inisialisasi | initialization | pengisian value pertama | filling in the first value | penginitialisasian | variables |
| interpolasi string | string interpolation | menyisipkan value ke dalam teks | inserting values into text | — | variables |
| identifier | identifier | nama untuk variable, type, procedure, atau module | a name for a variable, type, procedure, or module | pengenal | variables |
| error message | error message | output compiler yang menjelaskan masalah | compiler output that explains a problem | pesan error, pesan kesalahan, compiler message | variables |
| procedure | procedure | rutin yang bisa punya side effect (`proc`) | a routine that may have side effects (`proc`) | prosedur | procedures |
| fungsi | function | rutin tanpa side effect (`func`) | a routine with no side effects (`func`) | function | procedures |
| loop | loop | konstruksi untuk mengulang blok kode | a construct that repeats a block of code | looping, perulangan | loops |
| branching | branching | pemilihan path eksekusi (`if`, `case`, `when`) | choosing which path to execute (`if`, `case`, `when`) | percabangan | conditionals |
| array | array | kumpulan element bertipe sama, ukuran tetap | a fixed-size collection of elements of the same type | larik | collections |
| seq | seq | kumpulan element bertipe sama, ukuran dinamis (`seq`) | a dynamically sized collection of elements of the same type (`seq`) | sequence (kecuali penjelasan awal) | collections |
| object | object | type gabungan dengan field bernama | a composite type with named fields | objek | objects |
| exception | exception | kondisi error yang bisa ditangkap | an error condition that can be caught | pengecualian | exceptions |
| iterator | iterator | konstruksi yang menghasilkan value satu per satu (`yield`) | an object that yields values one at a time (`yield`) | — | loops |
| range | range | batas value dari awal sampai akhir (`a..b`, `a..<b`) | the bounds from start to end (`a..b`, `a..<b`) | range (kecuali di kode) | loops |
| index | index | posisi element di dalam koleksi, mulai dari 0 | the position of an element in a collection, starting at 0 | indeks | collections |
| element | element | satu value di dalam koleksi | a single value inside a collection | elemen | collections |
| literal | literal | value yang ditulis langsung di kode (`42`, `"teks"`, `@[1, 2]`) | a value written directly in code (`42`, `"text"`, `@[1, 2]`) | — | primitive-types |
| expression | expression | rangkaian kode yang menghasilkan value | a piece of code that produces a value | ekspresi | conditionals |
| statement | statement | satuan kode yang melakukan sesuatu, tidak selalu menghasilkan value | a unit of code that does something, not always producing a value | pernyataan | conditionals |
| parameter | parameter | nama value yang diterima procedure | the name of a value a procedure receives | argumen | procedures |
| default value | default value | value yang dipakai kalau argument tidak diberikan | the value used when an argument is not given | nilai default | procedures |
| inklusif | inclusive | batas akhir ikut dihitung (`0..5` berisi 5) | the end bound counts (`0..5` includes 5) | — | loops |
| eksklusif | exclusive | batas akhir tidak ikut dihitung (`0..<5` berhenti di 4) | the end bound does not count (`0..<5` stops at 4) | — | loops |
| ordinal type | ordinal type | type yang value itu bisa diurutkan dan dihitung (`int`, `char`, `enum`) | a type whose values can be ordered and counted (`int`, `char`, `enum`) | tipe ordinal | enums-and-sets |
| stack trace | stack trace | daftar calling yang ditampilkan saat program berhenti karena defect atau exception yang tidak tertangani | the list of calls shown when the program stops on a defect | jejak tumpukan | collections |
| biner | binary | file yang dihasilkan compile dan bisa dijalankan mesin | the compiled file a machine can run | binary | what-is-nim |
| mesin virtual | virtual machine | lapisan perangkat lunak yang menjalankan kode di atas CPU | a software layer that runs code on top of the CPU | VM | what-is-nim |
| backend | backend | target output compiler (C, C++, JavaScript) | a compiler output target (C, C++, JavaScript) | back-end | what-is-nim |
| debug build | debug build | build dengan pemeriksaan penuh, dipakai saat mengembangkan | a build with all checks on, used while developing | build debug | workflow |
| release build | release build | build teroptimasi, dipakai saat mengirim program | an optimized build, used when shipping the program | build rilis | workflow |
| garbage collector | garbage collector | pengelola memory otomatis pada mode GC klasik | the automatic memory manager in the classic GC mode | pemungut sampah | what-is-nim |
| destructor | destructor | procedure `=destroy` yang dipanggil saat value dibuang | a `=destroy` procedure called when a value is dropped | destructor (kecuali penjelasan) | what-is-nim |
| scope | scope | wilayah kode tempat sebuah nama bisa dipakai | the region of code where a name can be used | scope (kecuali penjelasan) | comments |
| comment | comment | catatan di kode yang diabaikan compiler | a note in code that the compiler ignores | komentar | comments |
| line comment | line comment | comment `#` sampai akhir line | a `#` comment to the end of the line | komentar baris, komentar satu baris | comments |
| block comment | block comment | comment `#[ ... ]#` yang bisa bersarang | a `#[ ... ]#` comment that can nest | komentar blok, komentar multi-baris | comments |
| doc comment | doc comment | comment `##` yang terbaca oleh `nim doc` | a `##` comment that `nim doc` reads | komentar dokumentasi, dokumentasi komentar | comments |
| package manager | package manager | tool yang memasang dan mengelola dependensi (`nimble`) | a tool that installs and manages dependencies (`nimble`) | pengelola paket | installation |
| standard library | standard library | kumpulan module bawaan compiler | the set of modules that ship with the compiler | library standar | installation |
| scaffold | project scaffold | kerangka file yang dibuat `nimble init` | the file skeleton that `nimble init` creates | scaffolding | installation |
| escape sequence | escape sequence | pasangan `\` + huruf yang mewakili character khusus (`\n`, `\t`) | a `\` plus a letter that stands for a special character (`\n`, `\t`) | escape sequence | strings |
| raw string | raw string | string `r"..."` yang tidak memproses escape | an `r"..."` string that does not process escapes | string mentah | strings |
| multiline string | multiline string | string `"""..."""` yang mempertahankan line baru | a `"""..."""` string that keeps line breaks | string multi-baris, string multiline | strings |
| slicing | slicing | mengambil potongan string/koleksi dengan range index | taking a piece of a string or collection by an index range | — | strings |
| overflow | overflow | value yang melewati batas type dan berakhir `OverflowDefect` | a value that crosses a type bound and ends in `OverflowDefect` | luapan | primitive-types |
| short-circuit | short-circuit evaluation | `and`/`or` berhenti begitu result-nya pasti | `and`/`or` stop as soon as the result is settled | evaluasi singkat | operators |
| bitwise | bitwise | operasi per bit (`and`, `or`, `xor`, `shl`, `shr`) | a per-bit operation (`and`, `or`, `xor`, `shl`, `shr`) | bitwise | operators |
| keanggotaan | membership | uji `in`/`notin` pada koleksi atau range | an `in`/`notin` test on a collection or a range | — | operators |
| presisi | precision | jumlah digit signifikan yang dijamin type float | the number of significant digits a float type guarantees | — | primitive-types |
| type conversion | type conversion | mengubah value ke type lain (`int()`, `float()`, `$`) | changing a value into another type (`int()`, `float()`, `$`) | casting (hindari) | primitive-types |
| newline | newline | character `\n` yang memindahkan output ke line berikutnya | the `\n` character that moves output to the next line | baris baru | printing |
| tuple | tuple | kumpulan value bertipe berbeda dengan urutan tetap | a fixed-order collection of values of different types | — | tuples |
| destructuring | destructuring | membongkar tuple menjadi variable terpisah | taking a tuple apart into separate variables | unpacking (kecuali penyebutan) | tuples |
| enum | enum | type dengan daftar value bernama yang sudah pasti | a type with a fixed list of named values | enumerasi | enums-and-sets |
| set | set | kumpulan value berbeda dari type ordinal (`set[Color]`) | a collection of distinct values of an ordinal type (`set[Color]`) | himpunan | enums-and-sets |
| ordinal value | ordinal value | posisi angka sebuah value enum (`ord(green)`) | the numeric position of an enum value (`ord(green)`) | nilai ordinal | enums-and-sets |
| bitset | bitset | set yang disimpan sebagai bit, dipakai untuk flag | a set stored as bits, used for flags | himpunan bit | enums-and-sets |
| constructor | constructor | expression yang membentuk value object (`Person(name: ...)`) | the expression that builds an object value (`Person(name: ...)`) | constructor (kecuali di kode) | objects |
| overloading | overloading | beberapa procedure bernama sama dengan daftar parameter berbeda | several same-named procedures with different parameter lists | overload | procedures |
| return value | return value | value yang dikembalikan procedure | the value a procedure returns | nilai kembalian, nilai balik | procedures |
| side effect | side effect | perubahan di luar return value (`echo`, menulis file, mengubah `var`) | a change beyond the return value (`echo`, writing a file, mutating a `var`) | efek samping | procedures |
| argument | argument | value yang dikirim saat procedure di-call | a value passed when a procedure is called | argumen | procedures |
| named argument | named argument | argument yang ditulis bersama nama parameter-nya | an argument written together with its parameter name | argumen bernama | procedures |
| referensi | reference | value yang menunjuk object di heap (`ref object`) | a value that points to an object on the heap (`ref object`) | reference | objects |
| value copy | value copy | penyalinan isi value, bukan alamatnya | copying the contents of a value, not its address | salinan nilai | objects |
| closure | closure | procedure yang membawa variable di sekitarnya | a procedure that carries the variables around it | — | closures |
| anonymous procedure | anonymous procedure | procedure tanpa nama yang dipakai sebagai value | a nameless procedure used as a value | prosedur anonim | closures |
| menangkap | capture | closure memakai variable dari scope luar | a closure using a variable from an outer scope | — | closures |
| calling convention | calling convention | aturan cara procedure di-call (`nimcall`, `closure`) | the rules for how a procedure is called (`nimcall`, `closure`) | konvensi pemanggilan | closures |
| calling | calling | tindakan menjalankan procedure | the act of running a procedure | pemanggilan | closures |
| caller | caller | kode yang memanggil procedure | the code that calls a procedure | pemanggil | closures |
| higienis | hygienic | makro atau template yang tidak membocorkan nama ke caller | a macro or template that does not leak names to the caller | higienis (kecuali sebagai sifat) | templates |
| ekspansi template | template expansion | kode template yang disalin compiler ke tempat calling | template code copied by the compiler to the call site | — | templates |
| instansiasi generic | generic instantiation | pembentukan type konkret dari generic pada pemakaian | forming a concrete type from a generic at the point of use | — | generics |
| typedesc | typedesc | type sebagai value, dipakai untuk overloading berbasis type | a type as a value, used for type-based overloading | — | generics |
| pointer | pointer | value yang menyimpan alamat memory (`ptr`) | a value that stores a memory address (`ptr`) | penunjuk | refs-and-pointers |
| alamat | address | lokasi value di memory, diperoleh lewat `addr` | the location of a value in memory, obtained with `addr` | — | refs-and-pointers |
| dereferensi | dereference | mengambil value yang ditunjuk sebuah pointer | reading the value a pointer points to | — | refs-and-pointers |
| penghitungan referensi | reference counting | menghitung pemakai sebuah value untuk tahu kapan dibebaskan | counting the users of a value to know when to free it | ref counting | memory-management |
| memory | memory | tempat program menyimpan data saat berjalan | where a program keeps data while it runs | memori | memory-management |
| memory management mode | memory management mode | pilihan pengelola memory compiler (`--mm:arc`, `--mm:orc`) | the compiler's choice of memory manager (`--mm:arc`, `--mm:orc`) | mode memori | memory-management |
| sumber daya | resource | hal yang harus dibebaskan setelah dipakai (file, socket) | something that must be released after use (a file, a socket) | resource | files-and-os |
| module | module | file atau folder yang berisi kode dan bisa diimpor | a file or folder that holds code and can be imported | modul | modules |
| ruang nama | namespace | wilayah nama yang dipisahkan module | a region of names kept apart by module | namespace | modules |
| mengimpor | import | memakai isi module lain | using the contents of another module | impor (kecuali di kode) | modules |
| mengekspor | export | menandai simbol module yang boleh dipakai dari luar | marking a module symbol that may be used from outside | ekspor (verba) | modules |
| effect | effect | sifat procedure yang dapat diperiksa compiler (`raises`) | a procedure trait the compiler can check (`raises`) | efek | exceptions |
| fasad | facade | module tipis yang menyatukan beberapa module lain | a thin module that unites several other modules | facade | modules |
| macro | macro | procedure compile-time yang menerima dan menghasilkan AST | a compile-time procedure that takes and produces an AST | — | macros |
| pohon sintaksis | abstract syntax tree | struktur pohon yang mewakili kode sumber | a tree structure that represents source code | AST (kecuali penjelasan awal) | macros |
| `quote do` | quote do | blok macro yang menulis kode seperti biasa | a macro block that writes code as usual | — | macros |
| untyped | untyped | parameter macro yang diterima sebelum diperiksa type | a macro parameter received before type checking | — | macros |
| konsep | concept | syarat bentuk type yang diperiksa saat overloading | a requirement on the shape of a type, checked during overloading | concept (kecuali di kode) | concepts |
| variant object | variant object | object yang field-nya bergantung pada satu penanda | an object whose fields depend on a single tag | — | variants-and-distinct |
| distinct | distinct | type baru dengan representasi sama tetapi tidak saling tukar | a new type with the same representation that does not interchange | — | variants-and-distinct |
| type alias | type alias | nama lain untuk type yang sudah ada, tanpa type baru | another name for an existing type, with no new type | — | variants-and-distinct |
| file | file | satuan penyimpanan di sistem file | a unit of storage in the file system | berkas | files-and-os |
| directory | directory | wadah file dan directory lain | a container for files and other directories | folder (kecuali sehari-hari) | files-and-os |
| path | path | lokasi file dalam sistem file | the location of a file in the file system | jalur | files-and-os |
| environment variable | environment variable | value konfigurasi dari proses induk | a configuration value from the parent process | env var | files-and-os |
| thread | thread | path eksekusi di dalam satu proses | a path of execution inside one process | utas | async |
| event loop | event loop | pengatur tugas async dalam satu thread | the scheduler of async tasks in one thread | putaran peristiwa | async |
| suite | suite | kumpulan test dalam `unittest` | a group of tests in `unittest` | — | unit-testing |
| test case | test case | satu pemeriksaan di dalam suite | one check inside a suite | kasus uji | unit-testing |
| FFI | foreign function interface | cara memanggil kode bahasa lain, di sini C | a way to call code from another language, here C | — | ffi-c |
| ABI | application binary interface | aturan tata letak dan calling di tingkat biner | the rules for layout and calls at the binary level | — | ffi-c |
| browser | browser | program yang menjalankan JavaScript dari compile | the program that runs the output of a JavaScript build | browser (kecuali di kode) | js-backend |
| subcommand | subcommand | command kedua di dalam satu tool CLI (`tool add`) | a second command inside a CLI tool (`tool add`) | subperintah | cli-tools |
| option | option | named argument yang mengubah perilaku command (`--count=4`) | a named argument that changes a command's behavior (`--count=4`) | opsi | cli-tools |
| exit code | exit code | angka yang dikembalikan proses ke caller-nya | the number a process returns to its caller | exit status | cli-tools |
| entry point | entry point | file atau procedure pertama yang dijalankan | the first file or procedure that runs | pintu masuk | cli-tools |
| route | route | pemetaan path dan metode HTTP ke handler | the mapping from an HTTP path and method to a handler | rute | http-api |
| handler | handler | fungsi yang menangani satu permintaan atau peristiwa | the function that handles one request or event | pengendali | http-api |
| socket | socket | ujung koneksi jaringan yang dipakai server dan klien | the endpoint of a network connection used by servers and clients | soket | http-api |
| row | row | satu catatan di dalam tabel atau result query | one record in a table or query result | baris (tabel) | database |
| query | query | permintaan data ke basis data | a request for data from a database | kueri | database |
| transaction | transaction | rangkaian perubahan yang harus berhasil semua atau tidak sama sekali | a group of changes that must all succeed or none at all | transaksi | database |
| package | package | satuan distribusi kode yang bisa dipasang | a distributable unit of code that can be installed | paket | nimble-packages |
| maintainer | maintainer | orang yang bertanggung jawab merawat sebuah package | the person responsible for looking after a package | pemelihara | nimble-packages |
| output | output | data yang dikirim program ke luar | data a program sends out | keluaran | printing |
| input | input | data yang masuk ke program | data that goes into a program | masukan | cli-tools |
| result | result | value yang dihasilkan operasi atau procedure | a value produced by an operation or procedure | hasil | procedures |
| line | line | satu line kode atau teks | one line of code or text | baris | printing |
| print | print | mengirim teks ke output | sending text to the output | mencetak (output program) | printing |
| assignment | assignment | penulisan value ke variable atau field | writing a value into a variable or field | penugasan | variables |
| comparison | comparison | operasi yang membandingkan dua value dan menghasilkan `bool` | an operation that compares two values and yields a `bool` | perbandingan | operators |
| flag | flag | value boolean yang menandai keadaan | a boolean value that marks a state | saklar (kecuali saklar listrik) | cli-tools |
| integer | integer | type angka cacah bertanda | a whole-number type | bilangan bulat | primitive-types |
| float | float | type angka berpecahan | a fractional-number type | bilangan pecahan, pecahan | primitive-types |
| message | message | teks yang disampaikan program ke pembaca atau sistem | text a program sends to the reader or the system | pesan | workflow |
| warning | warning | compiler message tentang kode yang patut diperiksa | a compiler message about code worth checking | peringatan | workflow |
| test | test | pemeriksaan otomatis terhadap perilaku kode | an automated check of code behavior | tes | unit-testing |
| release | release | versi yang diterbitkan dan diberi tag | a version that is published and tagged | rilis | workflow |
| regex | regular expression | pola teks yang dipakai `std/re` | a text pattern used by `std/re` | regexp | regex |
| capture group | capture group | bagian pola di dalam kurung yang ditangkap `matches` | the parenthesised part of a pattern captured by `matches` | grup tangkapan | regex |
| seed | seed | value awal *generator* acak | the starting value of a random generator | benih | times-and-random |
| timestamp | timestamp | jumlah detik sejak 1970 | seconds since 1970 | cap waktu | times-and-random |
| channel | channel | antrean *message* antar-*thread* di Nim | a message queue between threads in Nim | saluran | threads |
| endpoint | endpoint | alamat dan metode yang dilayani sebuah API | an address and method served by an API | titik akhir | http-api |
Aturan singkat:

- Istilah di kolom pertama dipakai di teks Indonesia; kolom English di teks Inggris.
- Nama tipe dan kata kunci selalu dalam bentuk kode: `array`, `seq`, `object`, `var`.
- Istilah asing yang belum ada padanan bakunya dicetak *miring*: *closure*, *iterator*, *macro*,
  *template*, *pragma*, *generic*.
- Identifier, komentar, dan string di `examples/` selalu bahasa Inggris, apa pun bahasanya buku.
