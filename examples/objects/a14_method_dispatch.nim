type
  Animal = ref object of RootObj
    name: string
  Dog = ref object of Animal
    tricks: int
  Cat = ref object of Animal

method speak(a: Animal): string {.base.} = a.name & " makes a sound"
method speak(d: Dog): string = d.name & " barks"
method speak(c: Cat): string = c.name & " meows"

let animals: seq[Animal] = @[Dog(name: "Rex", tricks: 3), Cat(name: "Milo")]
for a in animals:
  echo speak(a)
