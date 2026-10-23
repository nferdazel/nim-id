var calls = 0

proc next(): int =
  calls += 1
  calls

template min(a, b, c: untyped): untyped =
  if a < b:
    if a < c: a else: c
  else:
    if b < c: b else: c

proc minOf3[T](a, b, c: T): T =
  if a < b:
    if a < c: a else: c
  else:
    if b < c: b else: c

echo "template: ", min(next(), 100, 99), " (calls: ", calls, ")"
calls = 0
echo "proc: ", minOf3(next(), 100, 99), " (calls: ", calls, ")"
