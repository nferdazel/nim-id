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

Aturan singkat:

- Istilah di kolom pertama dipakai di teks Indonesia; kolom English di teks Inggris.
- Nama tipe dan kata kunci selalu dalam bentuk kode: `array`, `seq`, `object`, `var`.
- Istilah asing yang belum ada padanan bakunya dicetak *miring*: *closure*, *iterator*, *macro*,
  *template*, *pragma*, *generic*.
- Identifier, komentar, dan string di `examples/` selalu bahasa Inggris, apa pun bahasanya buku.
