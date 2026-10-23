import std/os

let path = "/srv/app/logs/today.txt"
let (dir, name, ext) = splitFile(path)

echo "dir:  ", dir
echo "name: ", name
echo "ext:  ", ext
echo "back: ", joinPath(dir, name & ext)
