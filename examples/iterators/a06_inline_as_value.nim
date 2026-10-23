iterator countTo(n: int): int =
  var i = 1
  while i <= n:
    yield i
    inc i

let it = countTo
