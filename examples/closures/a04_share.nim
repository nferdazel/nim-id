proc makePair(): (proc(): int, proc(): int) =
  var n = 0
  let increment = proc(): int =
    n += 1
    n
  let current = proc(): int = n
  (increment, current)

let (increment, current) = makePair()
echo current()
echo increment()
echo current()
