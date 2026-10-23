proc countTo(n: int): iterator (): int =
  result = iterator (): int =
    var i = 1
    while i <= n:
      yield i
      inc i

let numbers = countTo(3)
for n in numbers():
  echo n
