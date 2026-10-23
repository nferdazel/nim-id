proc pair[T](value: T): (T, T) =
  (value, value)

echo pair(3)
echo pair("a")
