template swapVals(a, b: untyped) =
  let tmp = a
  a = b
  b = tmp

var x = 1
var y = 2
swapVals(x, y)
echo x, " ", y
