proc readValue(): int =
  raise newException(ValueError, "missing")

proc useIt(): int {.raises: [].} =
  readValue()
