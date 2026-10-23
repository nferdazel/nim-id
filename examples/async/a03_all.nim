import std/asyncdispatch

proc fetch(name: string, delayMs: int): Future[string] {.async.} =
  await sleepAsync(delayMs)
  return name & " ready"

proc main() {.async.} =
  let results = await all(fetch("alpha", 30), fetch("beta", 10))
  for result in results:
    echo result

waitFor main()
