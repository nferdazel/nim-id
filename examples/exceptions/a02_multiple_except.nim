proc fail(mode: string) =
  if mode == "value":
    raise newException(ValueError, "bad value")
  elif mode == "io":
    raise newException(IOError, "disk full")

for mode in ["value", "io", "none"]:
  try:
    fail(mode)
    echo mode, ": ok"
  except ValueError:
    echo mode, ": value error"
  except CatchableError as e:
    echo mode, ": other error: ", e.msg
  finally:
    echo mode, ": done"
