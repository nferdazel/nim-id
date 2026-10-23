import std/macros

macro add(a, b: untyped): untyped =
  result = newTree(nnkInfix, ident"+", a, b)

macro double(x: typed): untyped =
  result = newTree(nnkInfix, ident"*", x, newLit(2))

echo add(1, 2)
echo double(21)
