template countTo(body: untyped) =
  var count {.inject.} = 0
  body
  echo "count: ", count

countTo:
  count += 2
  count += 3
