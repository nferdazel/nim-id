## A tiny reusable module: the kind of code that belongs in a package.

import std/strutils

proc wordCount*(text: string): int =
  ## Count the words in `text`.
  text.splitWhitespace().len

proc titleCase*(text: string): string =
  ## Capitalize the first letter of every word.
  for word in text.splitWhitespace():
    if result.len > 0:
      result.add ' '
    result.add word[0].toUpperAscii & word[1 .. ^1].toLowerAscii

when isMainModule:
  echo wordCount("nim is a small language")
  echo titleCase("nim is a small language")
