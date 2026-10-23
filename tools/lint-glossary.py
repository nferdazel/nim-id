#!/usr/bin/env python3
"""Lint istilah terlarang di prosa Indonesia.

Daftar di bawah adalah varian yang sudah diputuskan di `docs/glossary.md` kolom "Jangan" dan
tidak ambigu. Varian yang bergantung konteks (mis. `array` yang sah saat merujuk tipe) sengaja
tidak dimasukkan supaya lint tidak berisik.

Blok kode, inline code, dan target tautan dilewati: yang diperiksa hanya prosa.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
# Hanya naskah buku Indonesia. Dokumen internal boleh memakai istilah operasional
# (mis. "rilis" untuk nama perintah), dan glossary.md sengaja membahas varian terlarang.
BERKAS = sorted((ROOT / "books/id").rglob("*.qmd"))

TERLARANG = {
    # ejaan dan varian yang salah arah
    "peubah": "variable",
    "looping": "loop",
    "kompiler": "compiler",
    "pengompilasi": "compiler",
    "type data": "data type",
    "pendeklarasian": "deklarasi",
    "penginitialisasian": "inisialisasi",
    "waktu jalan": "runtime",
    "waktu kompilasi": "compile-time",
    "nilai kembalian": "return value",
    "pemungut sampah": "garbage collector",
    "manajer paket": "package manager",
    "build rilis": "release build",
    "build debug": "debug build",
    "scaffolding": "scaffold",
    "casting": "type conversion",
    # istilah yang sengaja tetap Inggris
    "concept": "konsep",
    "overload": "overloading",
    "object variant": "object varian",
    "penunjuk": "pointer",
    "utas": "thread",
    "putaran peristiwa": "event loop",
    "pengendali": "handler",
    "soket": "socket",
    "kueri": "query",
    "jejak tumpukan": "stack trace",
    "himpunan bit": "bitset",
    "evaluasi singkat": "short-circuit",
    "perancah proyek": "scaffold",
    "ruang lingkup": "scope",
    "pernyataan": "statement",
    "ekspresi": "expression",
    "peringatan": "warning",
    "pengelola paket": "package manager",
    "paket": "package",
    "tes": "test",
    "rilis": "release",
    "titik akhir": "endpoint",
    "berkas": "file",
    "larik": "array",
    "barisan": "seq",
    "himpunan": "set",
    "objek": "object",
    "pengecualian": "exception",
    "perulangan": "loop",
    "prosedur": "procedure",
    "pustaka": "library",
    "nilai balik": "return value",
    "kesalahan": "error",
    "kompilasi": "compile",
    "mengompilasi": "meng-compile",
    "dikompilasi": "di-compile",
    # istilah inti
    "tipe": "type",
    "nilai": "value",
    "variabel": "variable",
    "konstanta": "constant",
    "modul": "module",
    "efek": "effect",
    "indeks": "index",
    "elemen": "element",
    "rentang": "range",
    "karakter": "character",
    "subperintah": "subcommand",
    "opsi": "option",
    "kode keluar": "exit code",
    "pintu masuk": "entry point",
    "rute": "route",
    "pemelihara": "maintainer",
    "transaksi": "transaction",
    "peramban": "browser",
    "perintah": "command",
    "alat": "tool",
    "jalur": "path",
    "direktori": "directory",
    "konstruktor": "constructor",
    "destruktor": "destructor",
    # keputusan istilah: kosakata teknis inti memakai bentuk Inggris
    "keluaran": "output",
    "masukan": "input",
    "baris": "line (atau row untuk tabel)",
    "argumen": "argument",
    "komentar": "comment",
    "pesan": "message",
    "memori": "memory",
    "penugasan": "assignment",
    "perbandingan": "comparison",
    "percabangan": "branching",
    "pemanggilan": "calling",
    "pemanggil": "caller",
    "saklar": "flag",
    "bilangan bulat": "integer",
}

# Akhiran yang membuat istilah terlarang lolos dari pencocokan kata utuh (`pustakanya`,
# `tesnya`, `ruang lingkupnya`). Dicocokkan hanya di belakang istilah, bukan di depannya.
AKHIRAN = r"(?:nya|lah|kah|pun|ku|mu)?"

FENCE = re.compile(r"```.*?```", re.S)
INLINE = re.compile(r"`[^`]*`")
TAUTAN = re.compile(r"\]\([^)]*\)")


def prosa(teks):
    teks = FENCE.sub(" ", teks)
    teks = INLINE.sub(" ", teks)
    teks = TAUTAN.sub("] ", teks)
    return teks


def main():
    temuan = 0

    for berkas in BERKAS:
        if not berkas.exists():
            continue
        teks = prosa(berkas.read_text())
        for baris_no, baris in enumerate(teks.splitlines(), 1):
            rendah = baris.lower()
            for salah, benar in TERLARANG.items():
                if re.search(r"\b" + re.escape(salah) + AKHIRAN + r"\b", rendah):
                    rel = berkas.relative_to(ROOT)
                    print(f"{rel}:{baris_no}: '{salah}' seharusnya '{benar}'")
                    temuan += 1

    if temuan:
        print(f"\n{temuan} istilah terlarang")
        return 1

    print("istilah: oke")
    return 0


if __name__ == "__main__":
    sys.exit(main())
