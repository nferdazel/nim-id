import std/asyncdispatch

proc fetch(name: string, delayMs: int): Future[string] {.async.} =
  await sleepAsync(delayMs)
  return name & " ready"

proc main() {.async.} =
  let first = await fetch("alpha", 30)
  echo first
  let second = await fetch("beta", 10)
  echo second

waitFor main()
