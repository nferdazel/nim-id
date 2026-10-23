import std/parseopt

# Fixed arguments keep the example reproducible.
let args = @["--verbose", "-n", "3", "input.txt"]

var parser = initOptParser(args)
while true:
  parser.next()
  if parser.kind == cmdEnd:
    echo "end of command line: ", parser.kind
    break
  echo "[", parser.kind, "] key=", parser.key, " val=", repr(parser.val)
