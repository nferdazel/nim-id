# Dasar Pemrograman Nim / Learning Nim

A bilingual book about the [Nim](https://nim-lang.org) programming language, for readers who already
write code in another language but have never used one that compiles to native code.

## What this is

The repository holds the full source of *Dasar Pemrograman Nim* and its English edition *Learning
Nim*. It assumes you already write code in some language, and focuses on what is different in Nim:
static types, `result`, value and reference semantics, macros, and the road from a single file to a
package.

Both editions are written and kept side by side. A script holds them to the same shape (the same
chapter files, headings, and code blocks), and every example is compiled with its output compared on
each change, so the code in the book is code that runs.

Read it online: [Indonesian](https://nim.qouver.com) and [English](https://nim.qouver.com/en).
Download: [ID PDF, 414 pages](https://nim.qouver.com/Dasar-Pemrograman-Nim.pdf),
[EN PDF, 406 pages](https://nim.qouver.com/en/Learning-Nim.pdf), or from
[GitHub Releases](https://github.com/nferdazel/nim-id/releases).

What it is not: it is not a reference manual for the standard library, and it does not cover the C++
or JavaScript backend beyond the one chapter that introduces them. The book is self-published, free
online, without an ISBN.

## Status

Version `VERSION` at the root, currently 0.7.13, tagged `vX.Y.Z`. Both editions are complete through
the published chapter list and are kept in step by the parity gate; there is no half-translated
chapter.

## Architecture

The book is a Quarto project rendered twice, once per language, from one shared example corpus:

| Part | Contents |
|---|---|
| `books/id/` | Quarto project for the Indonesian edition, site root |
| `books/en/` | Quarto project for the English edition, served at `/en/` |
| `examples/` | One program per code block, grouped by chapter, with expected output files |
| `assets/` | Shared CSS, Typst partials and skip-link pages, copied into each book at build |
| `tools/` | Build and verification scripts |
| `ops/` | Caddy block, VPS setup, static deploy script |

The text is written once in Indonesian and translated; code is shared by both editions and only the
prose is translated. A parity script fails the build when the two editions lose the same shape.

Why it has this shape: Quarto with Typst is one source and two outputs, so the site and the PDF
cannot drift apart. The editions are two Quarto projects rather than one project with a profile,
because a Quarto book needs `index.qmd` at the project root and a per-format `output-dir` is
ignored. Deployment uses only the static part of the golden contract (ref guard, `flock`,
fetch/reset, symlink swap, health check): a static site has no container, so there is no
`:local`/`:prev` image to keep. For the same reason there is no `apps/` and `modules/` split — a
book has no backend and no database.

Inside the book:

| Part | Chapters | Topics |
|---|---|---|
| A: Fundamentals | 16 | installation, the edit-compile-run loop, types, `string`, control flow, `array`/`seq`, procedures, tuples, objects, enums and sets |
| B: Intermediate | 17 | modules, exceptions, iterators, closures, generics, templates, macros, concepts, references, memory management, the standard library, files and processes, testing, async, C FFI, the JavaScript backend |
| C: Practice | 10 | CLI tools, HTTP APIs, SQLite, Nimble packages, benchmarking, cross-compilation, regex, time and randomness, threads, a final project |
| Appendices | 5 | exercise answers, glossary, cheat sheet, Nim for programmers from other languages, further reading |

That is 43 chapters and 323 example programs.

## Repository layout

```text
books/     Quarto projects: id/ (site root) and en/ (served at /en/), same file names
assets/    shared ku.css, Typst partials, and skip-link pages, copied into each book at build
examples/  323 example programs grouped by chapter, with .expected / .expected-error files
tools/     build and verification scripts (see Quality gates)
ops/       Caddy block, VPS setup, and the static deploy script
docs/      writing guide, glossary source, publishing standards, release and VPS notes
public/    rendered site and PDFs (build output, not committed)
```

## Local development

### Prerequisites

[Quarto](https://quarto.org) 1.10.19, [Nim](https://nim-lang.org/install.html) 2.4.2, and Python 3. A
few examples also need Node (JavaScript backend) and libsqlite3 (the database chapter). If Quarto is
not on `PATH`, set `QUARTO=/path/to/quarto`.

### Quickstart

```sh
./task site       # render both editions into public/
./task pdf        # render both PDFs with Typst
./task check      # every gate: glossary, parity, examples, appendix, then the site
./task examples   # compile and verify every example
./task dev        # local preview of books/id with auto-reload
./task release    # bump VERSION from commit messages, then commit and tag
```

`./task help` lists the rest. `task` is a POSIX script, so the same command runs on a laptop and in CI.

## Configuration

The build reads one environment variable: `QUARTO`, the path to the Quarto binary when it is not on
`PATH`. Nothing else is configurable and no secret is involved; the deploy side takes its variables
from the host environment for `ops/scripts/deploy-static.sh`.

## Quality gates

`./task check` runs every gate below; CI runs the same scripts on each push and pull request.

| Script | Guards |
|---|---|
| `tools/verify-examples.sh` | every example compiles and runs; stdout matches `.expected`, failures match `.expected-error` |
| `tools/check-parity.py` | Indonesian and English files keep the same headings, code blocks, and cross-file links |
| `tools/lint-glossary.py` | rejected terms do not appear in the Indonesian prose |
| `tools/check-glossary-page.py` | both glossary pages match the canonical list in `docs/glossary.md` |
| `tools/check-appendix.py` | every code block in the exercise answers still compiles |

CI also runs the shared golden CI/CD contract check over `ops/`, and a gitleaks job that fails on its
own if a secret is ever committed.

## Deployment

A push to `main` triggers the VPS webhook. `ops/scripts/deploy-static.sh` fetches that commit,
rebuilds both editions on the server, and swaps a symlink to the new release; the previous release
stays available for rollback. A `v*` tag runs the same checks in CI and attaches both PDFs to a
GitHub Release. Setup steps and the Caddy block are in `ops/` and `docs/deploy-vps.md`.

## Documentation

- [`DESIGN.md`](DESIGN.md): the visual direction the web CSS and the PDF template follow.
- [`docs/writing-guide.md`](docs/writing-guide.md): chapter template, sentence rules, definition of done.
- [`docs/glossary.md`](docs/glossary.md): the canonical term list the glossary pages mirror.
- [`docs/publishing-standards.md`](docs/publishing-standards.md): what a published edition must satisfy.
- [`docs/release.md`](docs/release.md) and [`docs/deploy-vps.md`](docs/deploy-vps.md): release and VPS notes.
- [`CHANGELOG.md`](CHANGELOG.md): what changed in each published version.

## Security

There is no server application here, so the surface is small: the repository, the CI workflows and
the deploy script. A leaked credential or a workflow that could be made to run foreign code is a
security report; a factual error in a chapter is not. See [`SECURITY.md`](SECURITY.md).

## Contributing

Open an issue rather than a pull request; for anything larger than a typo, describe it there first, so
two people do not write the same chapter. Change any chapter in both editions at once and leave
`./task check` green. Commit messages use Conventional Commits, since `./task release` reads them to
decide the version bump. The full rules are in [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

- Book text (`books/`, `docs/`): CC BY-SA 4.0, see [LICENSE](LICENSE).
- Example code (`examples/`, `tools/`, and every code block in the book): MIT, see
  [LICENSE-CODE](LICENSE-CODE).
