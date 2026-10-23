type
  Named = concept x
    x.name is string

proc greet[T: Named](x: T): string =
  "Hello, " & x.name

echo greet(42)
