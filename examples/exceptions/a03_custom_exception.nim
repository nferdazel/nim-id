type NegativeAge = object of CatchableError

proc checkAge(age: int) =
  if age < 0:
    raise newException(NegativeAge, "age cannot be negative")

try:
  checkAge(-3)
except NegativeAge as e:
  echo "caught: ", e.msg
