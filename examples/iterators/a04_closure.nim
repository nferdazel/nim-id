iterator countBetween(a, b: int): int {.closure.} =
  var x = a
  while x <= b:
    yield x
    inc x

var it = countBetween
while true:
  let value = it(3, 5)
  if finished(it):
    break
  echo value
