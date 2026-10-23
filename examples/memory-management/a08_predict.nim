type Box = object
  name: string

proc `=destroy`(b: var Box) =
  echo "drop ", b.name

block:
  var a = Box(name: "a")
  echo "in block"
echo "end"
