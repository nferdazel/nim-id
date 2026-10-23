type Person = ref object
  name: string
  age: int

var p: Person
new(p)
p.name = "Ada"
p.age = 36
echo p.name, " is ", p.age
