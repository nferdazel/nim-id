try:
  raise newException(ValueError, "bad input")
except ValueError as e:
  echo "caught: ", e.msg
