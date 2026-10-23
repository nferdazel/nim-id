import std/macros

const Names = ["alice", "bob"]

macro makeGreeters(): untyped =
  result = newStmtList()
  for name in Names:
    let procName = ident("greet" & name)
    result.add quote do:
      proc `procName`(): string =
        "hello, " & `name`

makeGreeters()
echo greetalice()
echo greetbob()
