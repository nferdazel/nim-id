import std/macros

macro showAst(x: untyped): untyped =
  let tree = x.treeRepr
  result = quote do:
    echo `tree`

showAst(1 + 2)
