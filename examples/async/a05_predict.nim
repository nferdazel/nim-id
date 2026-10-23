import std/asyncdispatch

proc tag(name: string): Future[string] {.async.} =
  return "tag:" & name

proc main() {.async.} =
  echo await tag("a")
  echo await tag("b")

waitFor main()
