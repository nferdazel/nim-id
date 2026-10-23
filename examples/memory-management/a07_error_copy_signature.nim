type Box = object
  name: string

proc `=copy`(dest: var Box; src: string) =
  dest.name = src

var a = Box(name: "a")
var b = a
echo b.name
