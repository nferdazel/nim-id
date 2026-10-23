proc mayFail(ok: bool): int {.raises: [ValueError].} =
  if ok:
    1
  else:
    raise newException(ValueError, "failed")

try:
  echo mayFail(true)
  echo mayFail(false)
except ValueError as e:
  echo "error: ", e.msg
