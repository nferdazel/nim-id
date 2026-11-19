#!/usr/bin/env sh
# nim-id static checks for `./task gate`: the python linters over the glossary, parity,
# glossary page and appendix, plus the example compiler when Nim is on PATH.
# Deliberately no Quarto: the site/PDF render stays in `./task check` and the `book` CI job, so
# the gate works on a laptop that has no Quarto installed.
set -eu
cd "$(dirname "$0")/.."

command -v python3 >/dev/null 2>&1 || {
  printf '   python3 not on PATH: lint skipped here (CI runs it)\n'
  exit 0
}
python3 tools/lint-glossary.py
python3 tools/check-parity.py
python3 tools/check-glossary-page.py
python3 tools/check-appendix.py

if command -v nim >/dev/null 2>&1; then
  bash tools/verify-examples.sh
else
  printf '   nim not on PATH: example verification skipped here (CI runs it)\n'
fi
