type
  HasName = concept x
    x.name is string
  HasSize = concept x
    x.size is int
  Describable = HasName or HasSize

proc describe[T: Describable](x: T): string =
  when x is HasName:
    "name: " & x.name
  else:
    "size: " & $x.size

type
  Label = object
    name: string
  Box = object
    size: int

echo describe(Label(name: "kit"))
echo describe(Box(size: 3))
