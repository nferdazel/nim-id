import std/re
import std/strutils

# (?i) makes the rest of the pattern case-insensitive.
echo "NIM".match(re"(?i)nim")
echo "NIM".match(re"nim")

# re"..." is a raw string: write one backslash, not two.
echo "a.b".match(re"a\.b")
echo "axb".match(re"a\.b")

# For a fixed prefix or suffix, strutils is shorter than a regex.
echo "report.txt".endsWith(".txt")
