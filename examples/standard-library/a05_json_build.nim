import std/json

let person = %*{
  "name": "Ada",
  "age": 36,
  "tags": ["math", "code"]
}

echo person.pretty

type Person = object
  name: string
  age: int

let parsed = person.to(Person)
echo parsed.name, " is ", parsed.age
