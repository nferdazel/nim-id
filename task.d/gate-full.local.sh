#!/usr/bin/env sh
# nim-id test hook for `./task gate-full`: render both editions and the PDFs, which is what the
# `book` CI job proves. Needs Quarto. Without it the hook fails: a release gate that silently
# skipped the artifact would claim a book shipped that was never built. Pass --skip-check when
# that is a conscious choice.
set -eu
cd "$(dirname "$0")/.."

command -v "${QUARTO:-quarto}" >/dev/null 2>&1 || {
  printf '   quarto not installed: cannot build the book here\n' >&2
  exit 1
}
QUARTO="${QUARTO:-quarto}" sh ./task site
