try:
  raise newException(IOError, "a")
except ValueError:
  echo "value"
except CatchableError:
  echo "caught"
finally:
  echo "done"
