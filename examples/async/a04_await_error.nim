import std/asyncdispatch

proc work(): Future[int] {.async.} =
  return 42

proc main(): int =
  let value = await work()
  value

echo main()
