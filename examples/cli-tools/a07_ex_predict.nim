import std/parseopt

for kind, key, val in getopt(@["-ab", "--name=ana"]):
  echo "[", kind, "] key=", key, " val=", val
