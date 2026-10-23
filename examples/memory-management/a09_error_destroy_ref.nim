type Person = ref object
  name: string

proc `=destroy`(p: var Person) =
  echo "destroy ", p.name

var x = Person(name: "a")
echo x.name
