#!/usr/bin/env python3
"""Periksa blok kode di Lampiran A dengan `nim check`.

Jawaban latihan memuat potongan kode: lanjutan blok di atasnya, satu berkas dari
proyek berbilang berkas, atau daftar yang butuh `helper.c` buatan pembaca. Blok
seperti itu ditandai `{.nim .fragment}` dan dilewati. Sisanya wajib lolos, supaya
jawaban yang tidak bisa dikompilasi tidak bisa ikut rilis.

Kedua edisi mengutip kode yang sama; blok identik diperiksa sekali saja.
"""

import hashlib
import pathlib
import re
import subprocess
import sys
import tempfile
import textwrap

ROOT = pathlib.Path(__file__).resolve().parent.parent
BERKAS = [ROOT / "books/id/appendix/answers.qmd", ROOT / "books/en/appendix/answers.qmd"]

BLOK = re.compile(r"^([ \t]*)```\{\.nim([^}]*)\}\n(.*?)^[ \t]*```", re.S | re.M)


def main():
    sudah = set()
    gagal = 0
    jumlah = 0
    with tempfile.TemporaryDirectory() as tmp:
        for berkas in BERKAS:
            teks = berkas.read_text()
            for m in BLOK.finditer(teks):
                if "fragment" in m.group(2):
                    continue
                kode = textwrap.dedent(m.group(3)).strip()
                if not kode:
                    continue
                kunci = hashlib.sha1(kode.encode()).hexdigest()
                if kunci in sudah:
                    continue
                sudah.add(kunci)
                jumlah += 1
                berkas_nim = pathlib.Path(tmp) / f"blok{jumlah:03d}.nim"
                berkas_nim.write_text(kode + "\n")
                hasil = subprocess.run(
                    ["nim", "check", "--hints:off", "--warnings:off", str(berkas_nim)],
                    capture_output=True,
                    text=True,
                )
                if hasil.returncode == 0:
                    continue
                gagal += 1
                baris = teks.count("\n", 0, m.start()) + 1
                sebab = next(
                    (l.split("Error:", 1)[1].strip() for l in hasil.stderr.splitlines() if "Error:" in l),
                    "gagal dikompilasi",
                )
                print(f"{berkas.relative_to(ROOT)}:{baris}: {sebab}")

    if gagal:
        print(f"\nlampiran: {gagal} blok gagal dari {jumlah}")
        return 1
    print(f"lampiran: oke ({jumlah} blok)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
