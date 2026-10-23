type
  Named = concept x
    x.name is string

  Person = object
    name: string

  Robot = object
    name: string
    model: int

proc greet[T: Named](x: T): string =
  "Hello, " & x.name

echo greet(Person(name: "Ada"))
echo greet(Robot(name: "R2", model: 2))
