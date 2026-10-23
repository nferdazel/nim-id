template doubler(x: untyped): untyped =
  x + x

var calls = 0
proc bump(): int =
  inc calls
  calls

echo doubler(bump())
echo "calls: ", calls
