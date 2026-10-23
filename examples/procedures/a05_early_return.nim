proc classify(n: int): string =
  if n < 0:
    return "negative"
  if n == 0:
    return "zero"
  "positive"

echo classify(-3)
echo classify(0)
echo classify(9)
