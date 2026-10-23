iterator countTo(n: int): int =
  var i = 1
  while i <= n:
    yield i
    inc i

for value in countTo(3):
  echo value
