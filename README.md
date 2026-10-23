# Learning Nim

[![ci](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml/badge.svg)](https://github.com/nferdazel/nim-id/actions/workflows/ci.yml)
[![version](https://img.shields.io/github/v/tag/nferdazel/nim-id?label=version&color=1f3a5f)](https://github.com/nferdazel/nim-id/tags)
[![text license](https://img.shields.io/badge/text-CC%20BY--SA%204.0-1f3a5f)](LICENSE)
[![code license](https://img.shields.io/badge/code-MIT-1f3a5f)](LICENSE-CODE)
![Nim](https://img.shields.io/badge/Nim-2.2.12-1f3a5f)
![Quarto](https://img.shields.io/badge/Quarto-1.10-1f3a5f)

A book for learning the [Nim](https://nim-lang.org) programming language, for readers who have
written programs in another language but have never touched a language that compiles to native
code.

- **Indonesian:** [nim.qouver.com](https://nim.qouver.com)
- **English:** [nim.qouver.com/en](https://nim.qouver.com/en)
- **Indonesian PDF:** [Dasar-Pemrograman-Nim.pdf](https://nim.qouver.com/Dasar-Pemrograman-Nim.pdf)
- **English PDF:** [Learning-Nim.pdf](https://nim.qouver.com/en/Learning-Nim.pdf)

One Markdown source produces the web and PDF editions. Every example in `examples/` is compiled,
run, and its output compared automatically; one set of examples serves both languages, so a stale
snippet fails the build instead of slipping through.

## Contents

**Part 0, getting started:** what Nim is and why, installation, the `nim r` workflow, comments and
doc comments.

**Part A, fundamentals:** variables, primitive types and literals, strings, `echo` and formatting,
operators, branching, loops, `array`/`seq`/`openArray`, procedures, tuples, objects, enums and sets.

Exercise answers are in the appendix, on the same page for both languages.

## Running

You need [Nim](https://nim-lang.org/install.html) 2.2.12 and [Quarto](https://quarto.org) 1.10.x.

| Command | Result |
|---|---|
| `./task examples` | compile and verify every example |
| `./task site` | render Indonesian + English, output in `public/` |
| `./task id` / `./task en` | render one language only |
| `./task pdf` | PDF for both languages |
| `./task dev` | local preview with auto-reload |
| `./task check` | the full gate before a commit |
| `./task version` | print the book version number |
| `./task release` | bump the version from commit messages, then commit + tag |

If Quarto is not on `PATH`:

```sh
QUARTO=$HOME/.local/opt/bin/quarto ./task site
```

`task` is a POSIX script, not a Taskfile or just: the same command runs on a laptop and in CI,
with no extra tooling.

## Structure

```
books/
  id/                  Indonesian Quarto project (site root)
  en/                  English Quarto project (/en/), same file names
    _quarto.yml        chapter list and formats
    index.qmd          front page
    copyright.qmd      copyright and license
    chapters/*.qmd     43 chapters, English file names
    appendix/answers.qmd
examples/
  variables/           one folder per chapter, used by both languages
    a01_declaration.nim
    a01_declaration.expected             expected stdout
    a03_immutable_error.expected-error   expected compilation error
assets/                shared CSS and typst partials (copied during build)
tools/                 verify-examples, build-site, sync-assets, gen-version, release
ops/                   Caddy blocks, VPS setup, static deploy
docs/                  plan, writing guide, glossary, release
```

Files and folders are named in English. Example file names are **required** to follow
`aNN_name.nim`: Nim rejects module names that start with a digit or use a hyphen.

## Adding a chapter

1. Write `books/id/chapters/<name>.qmd` and `books/en/chapters/<name>.qmd` with the same file name.
2. Register the chapter in `books/id/_quarto.yml` and `books/en/_quarto.yml`.
3. Put the snippets in `examples/<name>/`, with `.expected` or `.expected-error` files.
4. Follow the [writing guide](docs/writing-guide.md); add new terms to the
   [glossary](docs/glossary.md) first.
5. `./task check` must be green before you commit.

## Releases

The version number lives in `VERSION` and is bumped automatically from commit messages by
`./task release`. A `vX.Y.Z` tag does not trigger CI again and does not trigger a deploy, because
the same commit already passed on `main`. The full rules are in [docs/release.md](docs/release.md).

## License

- **Book text** (`books/`, `docs/`): CC BY-SA 4.0, see [LICENSE](LICENSE).
- **Code samples** (`examples/`, `tools/`, code blocks inside the book): MIT, see
  [LICENSE-CODE](LICENSE-CODE).

If you quote the book, credit the source and link to `nim.qouver.com`. How to contribute is in
[CONTRIBUTING.md](CONTRIBUTING.md).
