type Box = object
  name: string

proc `=sink`(dest: var Box; src: Box) =
  echo "sinking ", src.name
  dest.name = src.name

var d = Box(name: "old")
d = Box(name: "temp")
echo "d = ", d.name
