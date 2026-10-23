import std/[os, algorithm]

let dir = getTempDir() / "nim_id_walk_demo"
createDir(dir)
writeFile(dir / "b.txt", "second")
writeFile(dir / "a.txt", "first")

var names: seq[string]
for kind, path in walkDir(dir):
  names.add extractFilename(path)

sort names
for name in names:
  echo name

removeDir(dir)
