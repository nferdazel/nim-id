type IntFn = proc(x: int): int {.nimcall.}

proc apply(f: IntFn, value: int): int = f(value)

proc outer(base: int): int =
  let g = proc(x: int): int = x + base
  apply(g, 1)

echo outer(10)
