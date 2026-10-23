template min(a, b, c: untyped): untyped =
  if a < b:
    if a < c: a else: c
  else:
    if b < c: b else: c

echo min(9, 2, 5)
echo min(4, 8, 1)
