let a = [10, 20, 30, 40, 50]

echo a[1 .. 3]
echo a[1 ..< 4]
echo a[^2 .. ^1]

proc total(values: openArray[int]): int =
  for value in values:
    result = result + value

echo total(toOpenArray(a, 1, 3))
