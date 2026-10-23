type Person = object
  name: string
  age: int

proc `$`(p: Person): string =
  p.name & " (" & $p.age & ")"

echo Person(name: "Ada", age: 36)
