proc total(values: openArray[int]): int =
  for value in values:
    result = result + value

echo total([1, 2, 3])
echo total(@[10, 20])
