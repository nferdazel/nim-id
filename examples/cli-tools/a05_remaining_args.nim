import std/parseopt

let args = @["--tag=work", "--", "file one.txt", "file two.txt"]

var tag = ""
var parser = initOptParser(args)

# Everything after "--" is a plain argument, including names that start with "-".
for kind, key, val in parser.getopt():
  if kind == cmdLongOption:
    if key == "tag":
      tag = val
    elif key == "":
      break

echo "tag: ", tag
echo "files: ", parser.remainingArgs
