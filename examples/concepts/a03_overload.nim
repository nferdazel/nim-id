type
  Named = concept x
    x.name is string
  Sized = concept x
    x.size is int

type
  Label = object
    name: string
  Box = object
    size: int

proc describe[T: Named](x: T): string = "named " & x.name
proc describe[T: Sized](x: T): string = "sized " & $x.size

echo describe(Label(name: "kit"))
echo describe(Box(size: 3))
