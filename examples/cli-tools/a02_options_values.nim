import std/[parseopt, strutils]

let args = @["--verbose", "--output=report.txt", "--count", "2", "input.txt"]

var verbose = false
var output = ""
var count = 0

# verbose and -v are flags; every other option may take a value.
for kind, key, val in getopt(args, shortNoVal = {'v'},
                             longNoVal = @["verbose"]):
  case kind
  of cmdLongOption, cmdShortOption:
    case key
    of "verbose", "v": verbose = true
    of "output", "o": output = val
    of "count", "c": count = parseInt(val)
    else: discard
  of cmdArgument:
    echo "argument: ", key
  of cmdEnd:
    discard

echo "verbose=", verbose
echo "output=", output, " count=", count
