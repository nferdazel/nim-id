# Changelog

All notable changes to *Dasar Pemrograman Nim* / *Learning Nim* are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres
to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). `VERSION` is the single source of the
version, and `./task release` bumps it from the Conventional Commits since the last tag before it
commits and tags `vX.Y.Z`. Both editions ship in one version: there is no Indonesian-only release.

History before this file was added is not reconstructed. The tags and their attached PDFs on the
releases page are the record for those releases.

## [Unreleased]

### Changed

- The Indonesian edition sets every foreign term in italics. The rule said so all along; the prose
  had drifted, leaving `compiler`, `string`, `field`, `print` and about 1.600 others upright.
  `tools/italicize-terms.py` repeats the pass when new prose lands.
- Every chapter's goal callout is now two sentences: one capability, then at most four concrete
  items. The fifth item and beyond moved to Ringkasan, so nothing was dropped. Applies to both
  editions.
- *wall-clock time* and *hotspot* replace the literal translations "waktu dinding" and "titik panas",
  and `tools/lint-glossary.py` rejects both. Word-count targets per chapter are gone: chapters run as
  long as the topic needs.
- The last upright glossary terms are italic: *heap* in six chapters and *compiler* in the
  benchmarking closer. `tools/italicize-terms.py` now also protects terms inside bold runs and skips
  the generated appendix glossary page.
- Every "Selanjutnya" section opens with its own sentence instead of "Bab berikutnya membahas".
  Prose paragraphs that ran past four lines are split, and the closing antithesis count drops to at
  most one per chapter.

## [0.7.15] - 2026-11-25

### Added

- SEO for both editions: `site-url`, book descriptions, Open Graph and Twitter cards, a favicon,
  `sitemap.xml` and `robots.txt`. Every page also gets a canonical URL, ID/EN `hreflang` alternates
  and `og:url`, which Quarto does not write for two separately rendered projects.
- The 404 page follows the language of the address: `/en/...` gets the English page, not the
  Indonesian one.
- `task.d/release.local.sh` stamps the release date into both books, so the PDF title page and the
  changelog no longer drift from `VERSION`.

### Changed

- The VPS deploy waits for the `Gate` check of the exact commit and aborts on red or timeout, so a
  failed build no longer reaches the live site.
- Dependabot pull requests skip the `examples` and `book` jobs; `preflight`, the secret scan and
  `Gate` still run, and every push runs the full graph.
- Index pages carry one `h1` again: "Prakata"/"Preface" is a level-2 heading under the book title
  block.

## [0.7.14] - 2026-11-20

### Changed

- CI/CD v2.0: one local gate (`./task gate`, `./task gate-full`), one release mechanism
  (`./task release`, no push without `--push`), the golden contract job renamed to `preflight`
  and required by every expensive job.

## [0.7.13] - 2026-11-14

See the releases page for the PDFs and the tag this file was introduced at.
