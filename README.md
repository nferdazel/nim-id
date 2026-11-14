# Dasar Pemrograman Nim / Learning Nim

[![ci](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml/badge.svg)](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml)
[![version](https://img.shields.io/github/v/tag/nferdazel/nim-id?label=version&color=1f3a5f)](https://github.com/nferdazel/nim-id/tags)
[![text license](https://img.shields.io/badge/text-CC%20BY--SA%204.0-1f3a5f)](LICENSE)
[![code license](https://img.shields.io/badge/code-MIT-1f3a5f)](LICENSE-CODE)

A bilingual book about the [Nim](https://nim-lang.org) programming language, for readers who already
write code in another language but have never used one that compiles to native code.

**[Read online](https://nim.qouver.com)** · [Indonesian](https://nim.qouver.com) ·
[English](https://nim.qouver.com/en)
**Download** · [ID PDF, 415 pages](https://nim.qouver.com/Dasar-Pemrograman-Nim.pdf) ·
[EN PDF, 407 pages](https://nim.qouver.com/en/Learning-Nim.pdf) ·
[GitHub Releases](https://github.com/nferdazel/nim-id/releases)

## What this is

The repository holds the full source of *Dasar Pemrograman Nim* and its English edition *Learning
Nim*. It assumes you already write code in some language, and focuses on what is different in Nim:
static types, `result`, value and reference semantics, macros, and the road from a single file to a
package.

Both editions are written and kept side by side. A script holds them to the same shape — the same
chapter files, headings, and code blocks — and every example is compiled with its output compared on
each change, so the code in the book is code that runs. The book is self-published, free online,
without an ISBN.

## Inside

| Part | Chapters | Topics |
|---|---|---|
| **A: Fundamentals** | 16 | installation, the edit–compile–run loop, types, `string`, control flow, `array`/`seq`, procedures, tuples, objects, enums and sets |
| **B: Intermediate** | 17 | modules, exceptions, iterators, closures, generics, templates, macros, concepts, references, memory management, the standard library, files and processes, testing, async, C FFI, the JavaScript backend |
| **C: Practice** | 10 | CLI tools, HTTP APIs, SQLite, Nimble packages, benchmarking, cross-compilation, regex, time and randomness, threads, a final project |
| **Appendices** | 5 | exercise answers, glossary, cheat sheet, Nim for programmers from other languages, further reading |

That is 43 chapters and 323 example programs. Code is written in English and shared by both editions;
only the prose is translated.

## Build it

You need [Quarto](https://quarto.org) 1.10.19, [Nim](https://nim-lang.org/install.html) 2.4.2, and
Python 3. A few examples also need Node (JavaScript backend) and libsqlite3 (the database chapter).

```sh
./task site       # render both editions into public/
./task pdf        # render both PDFs with Typst
./task check      # every gate: glossary, parity, examples, appendix, then the site
./task examples   # compile and verify every example
./task dev        # local preview with auto-reload
./task release    # bump VERSION from commit messages, then commit and tag
```

`./task help` lists the rest. If Quarto is not on `PATH`, set `QUARTO=/path/to/quarto`. `task` is a
POSIX script, so the same command runs on a laptop and in CI.

## Repository layout

```
books/     Quarto projects: id/ (site root) and en/ (served at /en/), same file names
assets/    shared ku.css, Typst partials, and skip-link pages, copied into each book at build
examples/  323 example programs grouped by chapter, with .expected / .expected-error files
tools/     build and verification scripts (see Quality gates)
ops/       Caddy block, VPS setup, and the static deploy script
docs/      plan, writing guide, glossary source, publishing standards, release and VPS notes
public/    rendered site and PDFs (build output, not committed)
```

## Quality gates

`./task check` runs every gate below; CI runs the same scripts on each push and pull request.

| Script | Guards |
|---|---|
| `tools/verify-examples.sh` | every example compiles and runs; stdout matches `.expected`, failures match `.expected-error` |
| `tools/check-parity.py` | Indonesian and English files keep the same headings, code blocks, and cross-file links |
| `tools/lint-glossary.py` | rejected terms do not appear in the Indonesian prose |
| `tools/check-glossary-page.py` | both glossary pages match the canonical list in `docs/glossary.md` |
| `tools/check-appendix.py` | every code block in the exercise answers still compiles |

## Deployment

A push to `main` triggers the VPS webhook. `ops/scripts/deploy-static.sh` fetches that commit,
rebuilds both editions on the server, and swaps a symlink to the new release; the previous release
stays available for rollback. A `v*` tag runs the same checks in CI and attaches both PDFs to a
GitHub Release. Setup steps and the Caddy block are in `ops/` and `docs/deploy-vps.md`.

## License

- **Book text** (`books/`, `docs/`): CC BY-SA 4.0, see [LICENSE](LICENSE).
- **Example code** (`examples/`, `tools/`, and every code block in the book): MIT, see
  [LICENSE-CODE](LICENSE-CODE).

## Contributing

Open an issue rather than a pull request; for anything larger than a typo, describe it there first,
so two people do not write the same chapter. Change any chapter in both editions at once and leave
`./task check` green. Commit messages use Conventional Commits, since `./task release` reads them to
decide the version bump. See [CONTRIBUTING.md](CONTRIBUTING.md).
