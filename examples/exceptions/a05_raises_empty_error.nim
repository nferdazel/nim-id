proc risky(): int =
  raise newException(ValueError, "boom")

proc safe(): int {.raises: [].} =
  risky()

try:
  echo safe()
except ValueError as e:
  echo "forced: ", e.msg
