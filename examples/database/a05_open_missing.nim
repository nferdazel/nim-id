import std/os

let path = getTempDir() / "nim_id_absent.json"

try:
  let text = readFile(path)
  echo "loaded ", text.len, " bytes"
except IOError:
  echo "no database yet"
