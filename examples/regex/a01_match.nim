import std/re

let line = "Ada, 36"

# =~ declares a `matches` array that holds the capture groups.
if line =~ re"(\w+),\s*(\d+)":
  echo "name: ", matches[0]
  echo "age: ", matches[1]
else:
  echo "no match"
