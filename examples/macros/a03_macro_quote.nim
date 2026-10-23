import std/macros

macro doubler(x: untyped): untyped =
  result = quote do:
    block:
      let it = `x`
      it + it

var calls = 0
proc bump(): int =
  inc calls
  calls

echo doubler(bump())
echo "calls: ", calls
