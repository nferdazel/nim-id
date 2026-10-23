import std/[json, os]

let path = getTempDir() / "nim_id_atomic.json"

proc save(path: string, rows: JsonNode) =
  let tmp = path & ".tmp"
  writeFile(tmp, rows.pretty)
  moveFile(tmp, path)

proc load(path: string): JsonNode =
  parseJson(readFile(path))

save(path, %*[{"title": "Dune"}])
save(path, %*[{"title": "Dune"}, {"title": "Emma"}])
echo load(path).len, " rows after commit"

# An update that fails before writing leaves the file unchanged.
try:
  raise newException(ValueError, "validation failed")
except ValueError:
  echo "update rejected"

echo load(path).len, " rows after rollback"
removeFile(path)
