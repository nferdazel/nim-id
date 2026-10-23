proc bump(counter: var int): int =
  counter = counter + 1
  counter

var hits = 0
bump(hits)
echo hits
