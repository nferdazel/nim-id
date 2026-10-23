proc describe(value: int): string =
  "int: " & $value

proc describe(value: string): string =
  "string: " & value

echo describe(42)
echo describe("answer")
