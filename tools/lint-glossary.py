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
    "variable": "variabel",
    "peubah": "variabel",
    "looping": "perulangan",
    "kompiler": "compiler",
    "pengompilasi": "compiler",
    "type data": "tipe data",
    "pendeklarasian": "deklarasi",
    "penginitialisasian": "inisialisasi",
    "waktu jalan": "runtime",
    "waktu kompilasi": "compile-time",
    "nilai kembalian": "nilai balik",
    "pemungut sampah": "garbage collector",
    "manajer paket": "pengelola paket",
    "build rilis": "release build",
    "build debug": "debug build",
    "scaffolding": "perancah proyek",
    "casting": "konversi tipe",
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
}

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
                if re.search(r"\b" + re.escape(salah) + r"\b", rendah):
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
