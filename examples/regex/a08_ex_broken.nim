import std/re

if "Ada, 36" =~ re"(\w+), (\d+)":
  echo matches[0]

echo matches[1]
