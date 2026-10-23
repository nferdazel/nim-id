import std/asyncdispatch

proc greeting(name: string): Future[string] {.async.} =
  return "hello, " & name

proc main() {.async.} =
  let message = await greeting("Nim")
  echo message

waitFor main()
