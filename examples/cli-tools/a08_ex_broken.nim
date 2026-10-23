import std/parseopt

for kind, key, val in getopt(@["--one"]):
  case kind
  of cmdLongOption:
    echo key
