import std/json

type Note* = object
  text*: string
  done*: bool

proc toJson*(note: Note): JsonNode =
  ## Turns one note into a JSON object.
  %*{"text": note.text, "done": note.done}

proc fromJson*(node: JsonNode): Note =
  ## Rebuilds one note from a JSON object.
  Note(text: node["text"].getStr, done: node["done"].getBool)

when isMainModule:
  let note = Note(text: "buy milk", done: false)
  echo $note.toJson
  echo note.toJson.fromJson.text
