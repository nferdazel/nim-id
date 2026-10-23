iterator counts(): int =
  yield 1
  yield 2

var sum = 0
for n in counts():
  sum = sum + n
echo sum
