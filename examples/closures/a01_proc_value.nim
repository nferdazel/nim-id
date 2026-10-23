proc add(a, b: int): int =
  a + b

# A procedure stored in a variable of type `proc`.
let op: proc(a, b: int): int = add

echo op(2, 3)
echo op(10, 20)
