proc make(value: int): proc(): int =
  result = proc(): int = value

var fns: seq[proc(): int]
for i in 0..2:
  fns.add(make(i))

for f in fns:
  echo f()
