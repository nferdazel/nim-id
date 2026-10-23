var fns: seq[proc(): int]
for i in 0..2:
  fns.add(proc(): int = i)

for f in fns:
  echo f()
