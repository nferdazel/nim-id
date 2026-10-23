template sumUp(body: untyped) =
  var total = 0
  body
  echo total

sumUp:
  total += 4
