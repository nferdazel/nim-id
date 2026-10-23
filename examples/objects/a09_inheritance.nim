type
  Animal = ref object of RootObj
    name: string
  Dog = ref object of Animal
    tricks: int

proc describe(a: Animal): string =
  a.name

var rex = Dog(name: "Rex", tricks: 3)
echo describe(rex), " knows ", rex.tricks, " tricks"
