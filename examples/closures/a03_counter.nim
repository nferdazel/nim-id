proc makeCounter(): proc(): int =
  var count = 0
  result = proc(): int =
    count += 1
    count

let c = makeCounter()
echo c()
echo c()
echo c()
