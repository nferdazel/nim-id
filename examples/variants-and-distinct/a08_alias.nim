type
  Alias = int
  UserId = distinct int

proc findUser(id: int): string = "found " & $id

echo findUser(Alias(3))
echo findUser(4)
echo findUser(int(UserId(5)))
