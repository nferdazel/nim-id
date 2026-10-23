import std/parseopt

let args = @["add", "--force", "notes.txt"]

var command = ""
var force = false
var files: seq[string]

# force is a flag, so it never swallows the next argument.
for kind, key, val in getopt(args, longNoVal = @["force"]):
  case kind
  of cmdArgument:
    if command == "":
      command = key
    else:
      files.add key
  of cmdLongOption, cmdShortOption:
    if key == "force":
      force = true
  of cmdEnd:
    discard

echo "command: ", command
echo "force: ", force
echo "files: ", files
