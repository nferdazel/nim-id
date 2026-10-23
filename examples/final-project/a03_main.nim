import std/[parseopt, os, strutils]
import a02_store

const Usage = """usage: notes <command> [options]

commands:
  add <text>       append a note
  list             print every note
  remove <index>   delete the note at <index>

options:
  -f, --file:path  where the notes are stored
"""

var storePath = getEnv("NOTES_FILE", getTempDir() / "nim_id_notes.json")

proc handle(command: string, operands: seq[string]): int =
  case command
  of "":
    echo Usage
    0
  of "add":
    if operands.len != 1:
      echo "add needs exactly one text argument"
      return 1
    addNote(storePath, operands[0])
    0
  of "list":
    let notes = loadNotes(storePath)
    if notes.len == 0:
      echo "no notes"
      return 0
    for index, note in notes:
      echo index + 1, ": ", note.text
    0
  of "remove":
    if operands.len != 1:
      echo "remove needs exactly one index"
      return 1
    let index = parseInt(operands[0]) - 1
    if not removeNote(storePath, index):
      echo "no note at index ", operands[0]
      return 1
    0
  else:
    echo "unknown command: ", command
    echo Usage
    1

proc main(): int =
  var command = ""
  var operands: seq[string]

  var parser = initOptParser()
  for kind, key, val in parser.getopt():
    case kind
    of cmdArgument:
      if command.len == 0:
        command = key
      else:
        operands.add key
    of cmdLongOption, cmdShortOption:
      if key == "file" or key == "f":
        storePath = val
      else:
        echo "unknown option: ", key
        return 1
    of cmdEnd:
      discard

  handle(command, operands)

when isMainModule:
  quit main()
