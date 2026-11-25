#!/usr/bin/env python3
"""Tambahkan canonical, hreflang, dan og:url ke situs yang sudah dirakit.

Quarto 1.10.19 sudah menulis description, Open Graph/Twitter card, favicon, robots.txt,
dan sitemap.xml dari `book.site-url`. Yang belum ada: canonical, tautan alternatif ID/EN,
dan og:url, karena dua edisi dirender sebagai dua project terpisah.

Jalankan setelah public/ selesai dirakit (tools/build-site.sh), sebelum deploy.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PUBLIC = ROOT / "public"
SITE = "https://nim.qouver.com"
BLOCK = "<!-- seo:start -->\n{}\n<!-- seo:end -->\n"
SITEMAP_INDEX = re.compile(r"(<loc>https://nim\.qouver\.com(?:/en)?/)index\.html(</loc>)")


def page_url(rel: str) -> str:
    page = rel[: -len("index.html")] if rel.endswith("index.html") else rel
    return f"{SITE}/{page}"


def counterpart(rel: str) -> str:
    return rel[3:] if rel.startswith("en/") else f"en/{rel}"


def head_links(rel: str) -> str:
    canonical = page_url(rel)
    other = counterpart(rel)
    tags = [
        f'<link rel="canonical" href="{canonical}">',
        '<meta property="og:type" content="website">',
        f'<meta property="og:url" content="{canonical}">',
    ]
    if (PUBLIC / other).is_file():
        id_url = canonical if not rel.startswith("en/") else page_url(other)
        en_url = canonical if rel.startswith("en/") else page_url(other)
        tags.extend(
            [
                f'<link rel="alternate" hreflang="id" href="{id_url}">',
                f'<link rel="alternate" hreflang="en" href="{en_url}">',
                f'<link rel="alternate" hreflang="x-default" href="{id_url}">',
            ]
        )
    return BLOCK.format("\n".join(tags))


def main() -> int:
    if not (PUBLIC / "index.html").is_file():
        sys.exit("public/index.html belum ada: jalankan setelah render")

    pages = 0
    for path in sorted(PUBLIC.rglob("*.html")):
        rel = path.relative_to(PUBLIC).as_posix()
        if rel == "404.html" or rel.startswith("site_libs/"):
            continue
        html = path.read_text(encoding="utf-8")
        html = re.sub(r"<!-- seo:start -->.*?<!-- seo:end -->\n?", "", html, flags=re.S)
        if "</head>" not in html:
            continue
        path.write_text(html.replace("</head>", head_links(rel) + "</head>", 1), encoding="utf-8")
        pages += 1

    sitemaps = 0
    for path in sorted(PUBLIC.rglob("sitemap.xml")):
        text = path.read_text(encoding="utf-8")
        cleaned = SITEMAP_INDEX.sub(r"\1\2", text)
        if cleaned != text:
            path.write_text(cleaned, encoding="utf-8")
        sitemaps += 1

    robots = PUBLIC / "robots.txt"
    if not robots.is_file() or f"Sitemap: {SITE}/en/sitemap.xml" not in robots.read_text(
        encoding="utf-8"
    ):
        sys.exit("public/robots.txt hilang atau tidak menyebut sitemap kedua edisi")

    print(f"seo: {pages} halaman, {sitemaps} sitemap, robots.txt ok")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
