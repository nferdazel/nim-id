import std/re

let text = "Ada Lovelace, 36"

# match is anchored at the start of the string; find scans the whole string.
echo "match from start: ", text.match(re"Ada")
echo "match in the middle: ", text.match(re"Lovelace")
echo "find in the middle: ", text.find(re"Lovelace")

# The openArray overload fills the capture groups and returns the start index.
var captures: array[2, string]
if text.find(re"(\w+),\s*(\d+)", captures) >= 0:
  echo "name: ", captures[0]
  echo "age: ", captures[1]
