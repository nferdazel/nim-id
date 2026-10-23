import std/re

for m in "one1two22three333".findAll(re"\d+"):
  echo m
