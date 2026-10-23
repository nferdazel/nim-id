import std/parseopt

const usage = "usage: notes [--help] <command> [<file>...]"

proc status(args: seq[string]): int =
  ## Returns the exit code the program would use.
  var command = ""
  for kind, key, val in getopt(args):
    case kind
    of cmdLongOption, cmdShortOption:
      if key == "help" or key == "h":
        echo usage
        return 0
    of cmdArgument:
      if command == "":
        command = key
    of cmdEnd:
      discard
  if command in ["add", "list"]:
    return 0
  2

echo "exit code: ", status(@["--help"])
echo "exit code: ", status(@["list"])
echo "exit code: ", status(@["drop"])
