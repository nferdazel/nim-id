proc demo() =
  var x = 1
  let frozen = x
  let readVar = proc(): int = x
  let readLet = proc(): int = frozen
  x = 99
  echo readVar()
  echo readLet()

demo()
