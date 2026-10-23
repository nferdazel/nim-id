type Box[T] = object
  value: T

proc boxed[T](value: T): Box[T] =
  Box[T](value: value)

echo boxed(7).value
echo boxed("text").value
