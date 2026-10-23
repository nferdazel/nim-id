proc total(items: seq[int]): int =
  for item in items:
    result = result + item

echo total(@[1, 2, 3, 4])
