import std/unittest

proc divide(a, b: int): int =
  if b == 0:
    raise newException(ValueError, "division by zero")
  a div b

suite "divide":
  test "returns the quotient":
    check divide(10, 2) == 5

  test "rejects a zero divisor":
    expect ValueError:
      discard divide(1, 0)

  test "keeps running after a passing require":
    require divide(9, 3) == 3
    check true
