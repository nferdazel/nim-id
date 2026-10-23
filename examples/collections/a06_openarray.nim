proc total(values: openArray[int]): int =
  for value in values:
    result = result + value

let fixed = [1, 2, 3]
let dynamic = @[4, 5, 6]

echo "array: ", total(fixed)
echo "seq: ", total(dynamic)
