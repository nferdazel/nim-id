proc nameOf(T: typedesc): string =
  $T

echo nameOf(int)
echo nameOf(string)
