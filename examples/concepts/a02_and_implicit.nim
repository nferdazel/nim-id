type
  Person = concept x
    x.name is string
    x.age is int

type Employee = object
  name: string
  age: int

proc show[T: Person](x: T): string =
  x.name & " is " & $x.age

echo show(Employee(name: "Ada", age: 36))
