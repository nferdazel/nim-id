import std/unittest

proc isEven(n: int): bool =
  n mod 2 == 0

suite "isEven":
  test "catches even numbers":
    check isEven(0)
    check isEven(2)
    check isEven(42)

  test "rejects odd numbers":
    check not isEven(1)
    check not isEven(7)
