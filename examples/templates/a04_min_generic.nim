proc minOf3[T](a, b, c: T): T =
  if a < b:
    if a < c: a else: c
  else:
    if b < c: b else: c

echo minOf3(9, 2, 5)
echo minOf3(4, 8, 1)
