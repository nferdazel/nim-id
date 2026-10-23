type Person = ref object
  name: string

var p = Person(name: "Ada")

echo p.name
echo p[].name
