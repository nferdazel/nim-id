proc makeAdder(base: int): proc(x: int): int =
  result = proc(x: int): int = x + base

let addBase: proc(x: int): int {.nimcall.} = makeAdder(10)
echo addBase(5)
