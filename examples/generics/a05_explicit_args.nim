proc makeSeq[T](count: int): seq[T] =
  for _ in 1..count:
    result.add default(T)

echo makeSeq[int](3)
echo makeSeq[string](2)
