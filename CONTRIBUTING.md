# Contributing

This book grows from reader corrections. The most useful reports are the small ones: an example
that stopped working, a confusing term, or a sentence with a typo.

## What you can send

| Type | How |
|---|---|
| Example fails on the latest Nim | open an issue, include the Nim version and the `nim r` output |
| Typos, unclear sentences, inconsistent terms | small pull request, one file per PR |
| Proposal for a new chapter | issue first, so two people do not write the same chapter |
| Translation | issue first; a third language needs a structural decision, not just translation |

## Before you send

```sh
QUARTO=$HOME/.local/opt/bin/quarto ./task check
```

That command compiles every example in `examples/`, compares the output, then renders both books.
If it fails, fix it first. CI runs the same checks.

## Writing a chapter

1. Read [`docs/writing-guide.md`](docs/writing-guide.md): chapter template, sentence rules, and
   the Definition of Done.
2. Add new terms to [`docs/glossary.md`](docs/glossary.md) first, then use them.
3. Every `{.nim}` block in a chapter must have a match in `examples/<chapter>/aNN_name.nim`, with
   `.expected` or `.expected-error`. The conventions are in `tools/verify-examples.sh`.
4. Write the Indonesian version in `books/id/chapters/` and the English version in
   `books/en/chapters/`, with the same file name, the same structure, and identical code blocks.
5. Code is always English: identifiers, comments, and text inside strings.

## Commit style

Commit messages use Conventional Commits prefixes, because `./task release` reads them to decide
the version bump:

```
feat: modules chapter
fix: loops example prints the wrong output on Nim 2.2.12
docs: clarify the closure section
chore: tidy the build scripts
```

`feat!:` or a `BREAKING CHANGE:` line marks a breaking change. The full rules are in
[`docs/release.md`](docs/release.md).

## Branches and pull requests

Do not push directly to `main`; a push to `main` goes straight to production through the deploy
webhook. Create a branch, open a pull request, and wait for CI to pass.

## Contribution license

By sending a contribution, you agree that it is licensed under the same license as the project:
book text under CC BY-SA 4.0 ([`LICENSE`](LICENSE)), code samples under MIT
([`LICENSE-CODE`](LICENSE-CODE)). Do not send text or code whose copyright is not yours.
