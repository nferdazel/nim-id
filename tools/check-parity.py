#!/usr/bin/env python3
"""Periksa paritas Indonesia vs English: struktur dan blok kode harus sama.

Yang dibandingkan untuk setiap berkas bernama sama:
  - jumlah heading
  - isi blok ```{.nim}
  - isi blok ```{.txt}
  - daftar target tautan markdown

Dipakai di `./task check` dan CI. Gagal (exit 1) kalau ada perbedaan.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
PASANGAN = [
    ("books/id/index.qmd", "books/en/index.qmd"),
    ("books/id/copyright.qmd", "books/en/copyright.qmd"),
    ("books/id/appendix/answers.qmd", "books/en/appendix/answers.qmd"),
    ("books/id/appendix/cheatsheet.qmd", "books/en/appendix/cheatsheet.qmd"),
    ("books/id/appendix/nim-for-others.qmd", "books/en/appendix/nim-for-others.qmd"),
    ("books/id/appendix/references.qmd", "books/en/appendix/references.qmd"),
    ("books/id/colophon.qmd", "books/en/colophon.qmd"),
]


def blok(teks, bahasa):
    return re.findall(r"```\{\.%s\}\n(.*?)```" % bahasa, teks, re.S)


def target_tautan(teks):
    """Hanya tautan antarberkas di dalam buku; URL eksternal boleh berbeda per bahasa."""
    return sorted(t for t in re.findall(r"\]\(([^)\s]+)", teks) if t.endswith(".qmd"))


def banding(berkas_id, berkas_en):
    a = berkas_id.read_text()
    b = berkas_en.read_text()
    masalah = []

    if a.count("\n#") != b.count("\n#"):
        masalah.append(f"jumlah heading beda: {a.count(chr(10) + '#')} vs {b.count(chr(10) + '#')}")

    for bahasa in ("nim", "txt"):
        if blok(a, bahasa) != blok(b, bahasa):
            masalah.append(f"blok {{{{{bahasa}}}}} berbeda")

    if target_tautan(a) != target_tautan(b):
        masalah.append(f"tautan antarberkas beda: {target_tautan(a)} vs {target_tautan(b)}")

    return masalah


def main():
    masalah_total = 0

    for id_path, en_path in PASANGAN:
        pi, pe = ROOT / id_path, ROOT / en_path
        if not pi.exists() or not pe.exists():
            print(f"GAGAL  {id_path} / {en_path}: berkas tidak ada")
            masalah_total += 1
            continue
        for m in banding(pi, pe):
            print(f"GAGAL  {id_path}: {m}")
            masalah_total += 1

    for pi in sorted((ROOT / "books/id/chapters").glob("*.qmd")):
        pe = ROOT / "books/en/chapters" / pi.name
        if not pe.exists():
            print(f"GAGAL  {pi.name}: tidak ada padanan English")
            masalah_total += 1
            continue
        for m in banding(pi, pe):
            print(f"GAGAL  chapters/{pi.name}: {m}")
            masalah_total += 1

    for pe in sorted((ROOT / "books/en/chapters").glob("*.qmd")):
        if not (ROOT / "books/id/chapters" / pe.name).exists():
            print(f"GAGAL  {pe.name}: tidak ada padanan Indonesia")
            masalah_total += 1

    if masalah_total:
        print(f"\n{masalah_total} masalah paritas")
        return 1

    print("paritas ID/EN: oke")
    return 0


if __name__ == "__main__":
    sys.exit(main())
