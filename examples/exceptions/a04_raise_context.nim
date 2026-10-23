import std/strutils

proc parseAge(text: string): int =
  try:
    result = parseInt(text)
  except ValueError:
    raise newException(ValueError, "not a number: " & text)

try:
  echo parseAge("42")
  echo parseAge("abc")
except ValueError as e:
  echo "error: ", e.msg
