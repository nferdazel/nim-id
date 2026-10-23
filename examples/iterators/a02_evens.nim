iterator evens(numbers: openArray[int]): int =
  for n in numbers:
    if n mod 2 == 0:
      yield n

for n in evens([1, 2, 3, 4, 5, 6]):
  echo n
