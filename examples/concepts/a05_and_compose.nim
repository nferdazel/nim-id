type
  Named = concept x
    x.name is string
  Aged = concept x
    x.age is int

type Employee = object
  name: string
  age: int

proc show[T: Named and Aged](x: T): string =
  x.name & " (" & $x.age & ")"

echo show(Employee(name: "Ada", age: 36))
