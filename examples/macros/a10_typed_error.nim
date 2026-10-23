import std/macros

macro echoType(x: typed): untyped =
  let typeName = $x.getType
  result = quote do:
    echo `typeName`

echoType(nonexistent)
