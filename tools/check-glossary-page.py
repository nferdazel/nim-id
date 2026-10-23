#!/usr/bin/env python3
"""Pastikan tabel glosarium di buku sama dengan `docs/glossary.md`.

`docs/glossary.md` adalah sumber istilah; lampiran glosarium disalin dari sana saat bab
bertambah. Tanpa pemeriksaan ini, keduanya pelan-pelan berbeda.

Dipakai di `./task check` dan CI.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
SUMBER = ROOT / "docs/glossary.md"
# (berkas, kolom judul, indeks kolom istilah Indonesia)
HALAMAN = [
    (ROOT / "books/id/appendix/glossary.qmd", "Istilah", 0),
    (ROOT / "books/en/appendix/glossary.qmd", "Term", 1),
]

PEMISAH = re.compile(r"^\|[\s:|-]+\|$")


def istilah(berkas, kolom=0):
    hasil = []
    for baris in berkas.read_text().splitlines():
        baris = baris.strip()
        if not baris.startswith("|") or PEMISAH.match(baris):
            continue
        sel = [s.strip() for s in baris.strip("|").split("|")]
        if not sel or sel[0] in ("Istilah", "Term"):
            continue
        if len(sel) <= kolom:
            continue
        hasil.append(sel[kolom].strip("`"))
    return hasil


def main():
    if not SUMBER.exists():
        print(f"GAGAL  {SUMBER.relative_to(ROOT)}: tidak ada")
        return 1

    acuan = istilah(SUMBER)
    masalah = 0

    for berkas, kolom, indeks in HALAMAN:
        rel = berkas.relative_to(ROOT)
        if not berkas.exists():
            print(f"GAGAL  {rel}: tidak ada")
            masalah += 1
            continue
        kepala = berkas.read_text().splitlines()
        if not any(kolom in b for b in kepala[:20]):
            print(f"GAGAL  {rel}: kolom '{kolom}' tidak ditemukan")
            masalah += 1

        hal = istilah(berkas, indeks)
        hilang = [t for t in acuan if t not in hal]
        lebih = [t for t in hal if t not in acuan]
        if hilang:
            print(f"GAGAL  {rel}: {len(hilang)} istilah belum ada, mis. {hilang[:5]}")
            masalah += 1
        if lebih:
            print(f"GAGAL  {rel}: {len(lebih)} istilah tidak ada di sumber, mis. {lebih[:5]}")
            masalah += 1

    if masalah:
        print(f"\n{masalah} masalah glosarium")
        return 1

    print(f"glosarium: oke ({len(acuan)} istilah)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
