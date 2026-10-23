proc fill[T; N: static int](value: T): array[N, T] =
  for i in 0..<N:
    result[i] = value

echo fill[char, 3]('z')
echo fill[int, 2](9)
