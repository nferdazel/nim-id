#!/usr/bin/env python3
"""Cetak miring istilah asing di naskah Indonesia.

Sumber istilah: kolom English `docs/glossary.md` yang bentuknya sama dengan kolom Indonesia
(artinya istilah itu dipakai apa adanya di teks Indonesia), ditambah kata Inggris lazim yang
diputuskan pemilik buku 2026-11-27 (compiler, string, command, character) dan istilah teknis
yang muncul di naskah tapi belum masuk glosarium.

Yang dilewati: fence kode, inline code, tautan tujuan, math, dan teks yang sudah miring.
Akhiran Indonesia menempel di luar tanda miring: `fieldnya` jadi `*field*-nya`.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
GLOS = ROOT / "docs/glossary.md"
TARGET = sorted((ROOT / "books/id").rglob("*.qmd"))

# Istilah yang dipakai apa adanya di kedua bahasa, plus kata Inggris lazim yang belum masuk
# glosarium. Tambah di sini kalau glosarium belum punya barisnya.
EKSTRA = [
    "command", "character", "string", "field", "template", "token", "pragma", "header",
    "parser", "parse", "library", "method", "benchmark", "profile", "profiler", "error",
    "annotation", "callback", "buffer", "stream", "generic", "anchor", "hint", "cheatsheet",
    "raw", "wildcard", "offset", "serialize", "deserialize", "literal", "tuple", "closure",
    "macro", "enum", "iterator", "variant", "scaffold", "harness", "snapshot", "toolchain",
    "setup", "layout", "grid", "stylesheet", "markup", "codebase", "build", "debug", "cache",
    "fallback", "wrapper", "nested", "lowercase", "uppercase", "whitespace", "backtick",
    "placeholder", "patch", "commit", "branch", "merge", "diff", "log", "lint", "runtime",
    "typography", "font", "theme", "plugin", "hook", "script", "shell", "prompt", "pattern",
    "matching", "escape", "spacing", "syntax", "semantic", "cursor", "caret", "tab",
]

AKHIRAN = r"(?:nya|lah|kah|pun|ku|mu)?"
SKIP = re.compile(r"(`[^`]*`|\*\*[^*]+\*\*|\*[^*]+\*|\$[^$]*\$|\]\([^)]*\))")


def istilah():
    nama = set(EKSTRA)
    for line in GLOS.read_text().splitlines():
        s = line.strip()
        if not s.startswith("|"):
            continue
        sel = [c.strip() for c in s.strip("|").split("|")]
        if len(sel) != 6 or sel[0] == "Istilah" or set(sel[0]) <= {"-", ":"}:
            continue
        idn, eng = sel[0], sel[1]
        if "`" in idn or "`" in eng:
            continue
        if idn.lower().replace("-", " ") == eng.lower().replace("-", " "):
            nama.add(eng)
    # Frasa panjang lebih dulu supaya "error message" tidak dicetak sebagai dua potong.
    return sorted(nama, key=lambda t: (-len(t), t))


def pola(daftar):
    bagian = []
    for t in daftar:
        kata = r"\s+".join(map(re.escape, t.split()))
        bagian.append(kata)
    return re.compile(
        r"(?<![\w*\-])(?:" + "|".join(bagian) + r")" + AKHIRAN + r"(?![\w*\-])", re.I
    )


def utama():
    daftar = istilah()
    cocok = pola(daftar)
    total = 0
    for berkas in TARGET:
        teks = berkas.read_text()
        keluar = []
        dalam_fence = False
        for baris in teks.split("\n"):
            if baris.lstrip().startswith("```"):
                dalam_fence = not dalam_fence
                keluar.append(baris)
                continue
            if dalam_fence:
                keluar.append(baris)
                continue
            potong = SKIP.split(baris)
            for i in range(0, len(potong), 2):
                def ganti(m):
                    nonlocal total
                    total += 1
                    return "*" + m.group(0) + "*"
                potong[i] = cocok.sub(ganti, potong[i])
            keluar.append("".join(potong))
        baru = "\n".join(keluar)
        if baru != teks:
            berkas.write_text(baru)
    print(f"{total} istilah dicetak miring")
    return 0


if __name__ == "__main__":
    sys.exit(utama())
