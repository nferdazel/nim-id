proc minMax(values: openArray[int]): tuple[min, max: int] =
  result.min = values[0]
  result.max = values[0]
  for value in values:
    if value < result.min:
      result.min = value
    if value > result.max:
      result.max = value

let (low, high) = minMax([3, 1, 4, 1, 5])
echo low, "..", high
