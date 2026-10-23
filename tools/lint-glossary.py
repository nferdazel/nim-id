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
# glossary.md dan plan.md sengaja dikecualikan: keduanya membahas varian terlarang.
BERKAS = sorted(
    list((ROOT / "books/id").rglob("*.qmd"))
    + [ROOT / "README.md", ROOT / "CONTRIBUTING.md"]
    + [ROOT / "docs/writing-guide.md", ROOT / "docs/release.md"]
)

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
