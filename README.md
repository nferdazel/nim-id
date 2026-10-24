# Dasar Pemrograman Nim / Learning Nim

[![ci](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml/badge.svg)](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml)
[![version](https://img.shields.io/github/v/tag/nferdazel/nim-id?label=version&color=1f3a5f)](https://github.com/nferdazel/nim-id/tags)
[![text license](https://img.shields.io/badge/text-CC%20BY--SA%204.0-1f3a5f)](LICENSE)
[![code license](https://img.shields.io/badge/code-MIT-1f3a5f)](LICENSE-CODE)

A bilingual book about the [Nim](https://nim-lang.org) programming language, for readers who already
write code in another language but have never used one that compiles to native code.

**Read online:** [Indonesian](https://nim.qouver.com) · [English](https://nim.qouver.com/en)  
**Download / releases:** [ID PDF](https://nim.qouver.com/Dasar-Pemrograman-Nim.pdf) · [EN PDF](https://nim.qouver.com/en/Learning-Nim.pdf) · [GitHub Releases](https://github.com/nferdazel/nim-id/releases)

## What this is

The repository holds the full source of *Dasar Pemrograman Nim* and its English edition *Learning
Nim*. It assumes you already write code in some language, and focuses on what is different in Nim:
static types, `result`, value and reference semantics, macros, and the road from a single file to a
package. That is 43 chapters in three parts, then five appendices: exercise answers, a glossary, a
cheat sheet, Nim for programmers from other languages, and further reading.

Both editions are written and kept side by side, and a script holds them to the same shape: the same
chapter files, headings, and code blocks. Every example is compiled and its output compared on each
change, so the code in the book is code that runs. The book is self-published, free online, without
an ISBN.

## Read it

Language | Web | PDF
--- | --- | ---
Indonesian | [nim.qouver.com](https://nim.qouver.com) | [Dasar-Pemrograman-Nim.pdf](https://nim.qouver.com/Dasar-Pemrograman-Nim.pdf)
English | [nim.qouver.com/en](https://nim.qouver.com/en) | [Learning-Nim.pdf](https://nim.qouver.com/en/Learning-Nim.pdf)

## Build it

You need [Quarto](https://quarto.org) 1.10.19, [Nim](https://nim-lang.org/install.html) 2.2.12, and
Python 3. Quarto renders the site and both PDFs, Python 3 runs the check scripts, and Nim compiles
the examples; Node is needed only by the JavaScript-backend examples.

```sh
./task site       # render both editions into public/
./task pdf        # render both PDFs with Typst
./task check      # every gate: examples, parity, glossary, appendix, then the site
./task release    # bump VERSION from commit messages, then commit and tag
./task examples   # compile and verify every example (needs Nim)
```

`./task help` lists the rest. If Quarto is not on `PATH`, set `QUARTO=/path/to/quarto`. `task` is a
POSIX script, so the same command runs on a laptop and in CI.

## Repository layout

```
books/     Quarto projects: id/ (site root) and en/ (served at /en/), same file names
assets/    shared ku.css, Typst partials, and skip-link pages, copied into each book at build
examples/  320 example programs grouped by chapter, with .expected / .expected-error files
tools/     build and verification scripts (see Quality gates)
ops/       Caddy block, VPS setup, and the static deploy script
docs/      plan, writing guide, glossary source, publishing standards, release and VPS notes
public/    rendered site and PDFs (build output, not committed)
```

## Quality gates

`./task check` runs every gate below; CI runs the same scripts on each push and pull request.

Script | Guards
--- | ---
`tools/verify-examples.sh` | every example compiles and runs; stdout matches `.expected`, failures match `.expected-error`
`tools/check-parity.py` | Indonesian and English files keep the same headings, code blocks, and cross-file links
`tools/lint-glossary.py` | rejected terms do not appear in the Indonesian prose
`tools/check-glossary-page.py` | both glossary pages match the canonical list in `docs/glossary.md`
`tools/check-appendix.py` | every code block in the exercise answers still compiles

## Deployment

A push to `main` triggers the VPS webhook, which rebuilds the site and swaps it live; a `v*` tag
publishes both PDFs as a GitHub Release. The Caddy config, setup steps, and scripts are in `ops/`.

## License

- **Book text** (`books/`, `docs/`): CC BY-SA 4.0, see [LICENSE](LICENSE).
- **Example code** (`examples/`, `tools/`, and every code block in the book): MIT, see
  [LICENSE-CODE](LICENSE-CODE).

## Contributing

Open an issue rather than a pull request; for anything larger than a typo, describe it there first,
so two people do not write the same chapter. Change any chapter in both editions at once and leave
`./task check` green. Commit messages use Conventional Commits, since `./task release` reads them to
decide the version bump. See [CONTRIBUTING.md](CONTRIBUTING.md).
