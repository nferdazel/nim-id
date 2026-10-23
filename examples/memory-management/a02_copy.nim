type Box = object
  name: string

proc `=copy`(dest: var Box; src: Box) =
  echo "copying ", src.name
  dest.name = src.name

var a = Box(name: "a")
var b = a
echo "b = ", b.name
