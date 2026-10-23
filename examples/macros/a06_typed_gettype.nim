import std/macros

macro typedDebug(x: typed): untyped =
  let typeName = $x.getType
  result = quote do:
    echo `typeName`, ": ", `x`

typedDebug(1 + 2)
typedDebug("a" & "b")
