proc describe(n: int): string =
  case n
  of 0: return "zero"
  of 1: return "one"

echo describe(0)
