type Box = object
  name: string

var a = Box(name: "a")
var b = move(a)
echo "b = ", b.name
echo "a = ", repr(a.name)
