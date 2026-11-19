# Changelog

All notable changes to *Dasar Pemrograman Nim* / *Learning Nim* are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres
to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). `VERSION` is the single source of the
version, and `./task release` bumps it from the Conventional Commits since the last tag before it
commits and tags `vX.Y.Z`. Both editions ship in one version: there is no Indonesian-only release.

History before this file was added is not reconstructed. The tags and their attached PDFs on the
releases page are the record for those releases.

## [Unreleased]

## [0.7.14] - 2026-11-20

### Changed

- CI/CD v2.0: one local gate (`./task gate`, `./task gate-full`), one release mechanism
  (`./task release`, no push without `--push`), the golden contract job renamed to `preflight`
  and required by every expensive job.

## [0.7.13] - 2026-11-14

Current edition. See the releases page for the PDFs and the tag this file was introduced at.
