#!/usr/bin/env sh
# Repo hook for ./task release: stamp the release date into both books.
# The release script already writes VERSION and cuts CHANGELOG; the book date is repo-specific.
set -eu
cd "$(dirname "$0")/.."

NEW="${1:?new version required}"
TODAY=$(date +%Y-%m-%d)

for f in books/id/_quarto.yml books/en/_quarto.yml; do
  perl -pi -e "s/^  date: \"[0-9-]*\"\$/  date: \"$TODAY\"/" "$f"
done

git add books/id/_quarto.yml books/en/_quarto.yml
printf '   book date -> %s (v%s)\n' "$TODAY" "$NEW"
