template square(x: untyped): untyped =
  x * x

var n = 0
proc next(): int =
  n += 1
  n
echo square(next())
echo n
