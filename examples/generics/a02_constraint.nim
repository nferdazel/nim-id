proc double[T: SomeInteger](value: T): T =
  value * 2

echo double(21)
echo double(5'i8)
