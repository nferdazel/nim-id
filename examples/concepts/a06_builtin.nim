proc total[T: SomeNumber](xs: seq[T]): T =
  for x in xs:
    result += x

echo total(@[1, 2, 3])
echo total(@[1.5, 2.5])
