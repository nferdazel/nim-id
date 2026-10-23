type Person = ref object
  name: string

var p = Person(name: "Ada")
echo p.name

var q: Person
new(q)
q.name = "Grace"
echo q.name
