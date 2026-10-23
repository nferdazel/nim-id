import std/[os, strutils]

let path = getTempDir() / "nim_id_files_demo.txt"

writeFile(path, "first line\nsecond line")

for line in readFile(path).splitLines():
  echo line

removeFile(path)
echo "exists after remove: ", fileExists(path)
