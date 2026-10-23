import std/[json, os]

type Note* = object
  text*: string
  done*: bool

proc toJson*(note: Note): JsonNode =
  ## Turns one note into a JSON object.
  %*{"text": note.text, "done": note.done}

proc fromJson*(node: JsonNode): Note =
  ## Rebuilds one note from a JSON object.
  Note(text: node["text"].getStr, done: node["done"].getBool)

proc loadNotes*(path: string): seq[Note] =
  ## Returns an empty sequence when the file does not exist yet.
  if not fileExists(path):
    return @[]
  let root = parseJson(readFile(path))
  for item in root:
    result.add fromJson(item)

proc saveNotes*(path: string, notes: seq[Note]) =
  var items = newJArray()
  for note in notes:
    items.add note.toJson
  writeFile(path, $items)

proc addNote*(path, text: string) =
  var notes = loadNotes(path)
  notes.add Note(text: text, done: false)
  saveNotes(path, notes)

proc removeNote*(path: string, index: int): bool =
  ## Removes the note at `index`; returns false when the index is out of range.
  var notes = loadNotes(path)
  if index < 0 or index >= notes.len:
    return false
  notes.delete index
  saveNotes(path, notes)
  true

when isMainModule:
  let path = getTempDir() / ("nim_id_notes_demo_" & $getCurrentProcessId() & ".json")
  removeFile(path)

  addNote(path, "buy milk")
  addNote(path, "write the chapter")

  let notes = loadNotes(path)
  echo "notes: ", notes.len
  echo "first: ", notes[0].text

  echo "removed: ", removeNote(path, 0)
  echo "left: ", loadNotes(path).len

  removeFile(path)
