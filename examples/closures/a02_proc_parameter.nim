proc apply(f: proc(x: int): int, value: int): int =
  f(value)

proc twice(x: int): int =
  x * 2

echo apply(twice, 5)
echo apply(proc(x: int): int = x + 1, 10)
