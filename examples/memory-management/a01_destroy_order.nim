type Box = object
  name: string

proc `=destroy`(b: var Box) =
  echo "destroy ", b.name

proc make(): Box =
  echo "make"
  Box(name: "temp")

proc main() =
  var x = Box(name: "outer")
  echo "before block"
  block:
    let y = make()
    echo "inside block: ", y.name
  echo "after block"

main()
