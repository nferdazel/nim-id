type
  Animal = ref object of RootObj
    name: string
  Dog = ref object of Animal
  Cat = ref object of Animal

proc speak(a: Animal): string = "a sound"
proc speak(d: Dog): string = "a bark"
proc speak(c: Cat): string = "a meow"

let animals: seq[Animal] = @[Dog(name: "Rex"), Cat(name: "Milo")]
for a in animals:
  echo speak(a)
