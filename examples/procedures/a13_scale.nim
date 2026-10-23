proc scale(value: int, factor = 2): int =
  value * factor

echo scale(5)
echo scale(5, factor = 10)
