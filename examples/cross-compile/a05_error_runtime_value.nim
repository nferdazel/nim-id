import std/os

let requested = paramStr(0)

# `when` needs a value that is known before the program runs.
when requested.len > 0:
  echo "the program has a name"
