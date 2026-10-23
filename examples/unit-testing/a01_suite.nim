import std/unittest

proc add(a, b: int): int =
  a + b

suite "add":
  test "adds two positive numbers":
    check add(2, 3) == 5

  test "adds a negative number":
    check add(-1, 4) == 3
