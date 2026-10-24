#!/usr/bin/env python3
"""Bangun tabel lampiran Glosarium dari `docs/glossary.md` untuk kedua bahasa.

`docs/glossary.md` adalah satu-satunya sumber: kolom 1 istilah Indonesia, kolom 2 istilah
English, kolom 4 definisi English. Skrip ini menulis ulang tabel di
`books/{id,en}/appendix/glossary.qmd` supaya urutan dan ejaannya selalu sama dengan sumber.

Dipakai sebelum `./task check`; `tools/check-glossary-page.py` yang memeriksa hasilnya.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
GLOS = ROOT / "docs/glossary.md"
CH = {"id": ROOT / "books/id/chapters", "en": ROOT / "books/en/chapters"}
OUT = {
    "id": ROOT / "books/id/appendix/glossary.qmd",
    "en": ROOT / "books/en/appendix/glossary.qmd",
}
JUDUL = {"id": "# Glosarium", "en": "# Glossary"}
KEPALA = {"id": "| Istilah | Definisi | Bab |", "en": "| Term | Definition | Chapter |"}
PEMISAH = "| --- | --- | --- |"
CATATAN = {
    "id": "Istilah baru ditambahkan ke daftar induk lebih dulu, baru dipakai di bab.",
    "en": "New terms go into the master list first, and only then into a chapter.",
}


def kosong(nilai):
    return nilai in ("", "-", "\u2014", "\u2013", "n/a")


def judul(berkas):
    if not berkas.exists():
        return None
    for baris in berkas.read_text().splitlines():
        if baris.startswith("# "):
            return baris[2:].strip()
    return berkas.stem


def main():
    baris = []
    for line in GLOS.read_text().splitlines():
        s = line.strip()
        if not s.startswith("|"):
            continue
        sel = [c.strip() for c in s.strip("|").split("|")]
        if len(sel) != 6 or sel[0] == "Istilah" or set(sel[0]) <= {"-", ":"}:
            continue
        baris.append(sel)

    if not baris:
        print("GAGAL docs/glossary.md: tabel kosong")
        return 1

    # Alphabetical per edition: a glossary is a lookup table, and the two
    # languages sort differently ("declaration" and "deklarasi" do not land in
    # the same place). Markup is ignored while sorting.
    def kunci(nilai):
        return re.sub(r"[*`]", "", nilai).lower()

    urut = {
        "id": sorted(baris, key=lambda r: kunci(r[0])),
        "en": sorted(baris, key=lambda r: kunci(r[1])),
    }

    tabel = {"id": [], "en": []}
    for istilah, english, definisi, definisi_en, _, bab in urut["id"]:
        tautan = {}
        for lang in ("id", "en"):
            if kosong(bab):
                tautan[lang] = "-"
            else:
                berkas = CH[lang] / (bab + ".qmd")
                t = judul(berkas)
                tautan[lang] = f"[{t}](../chapters/{bab}.qmd)" if t else f"[{bab}](../chapters/{bab}.qmd)"
        tabel["id"].append(f"| {istilah} | {definisi} | {tautan['id']} |")

    for istilah, english, definisi, definisi_en, _, bab in urut["en"]:
        tautan = {}
        for lang in ("id", "en"):
            if kosong(bab):
                tautan[lang] = "-"
            else:
                berkas = CH[lang] / (bab + ".qmd")
                t = judul(berkas)
                tautan[lang] = f"[{t}](../chapters/{bab}.qmd)" if t else f"[{bab}](../chapters/{bab}.qmd)"
        tabel["en"].append(f"| {english} | {definisi_en} | {tautan['en']} |")

    for lang in ("id", "en"):
        teks = "\n".join([JUDUL[lang], "", KEPALA[lang], PEMISAH] + tabel[lang] + ["", CATATAN[lang], ""])
        OUT[lang].write_text(teks)
        print(f"{lang}: {len(tabel[lang])} istilah -> {OUT[lang].relative_to(ROOT)}")

    return 0


if __name__ == "__main__":
    sys.exit(main())
