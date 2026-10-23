import std/typedthreads

type Count = tuple[text: string, characters: int]

var results: Channel[Count]

proc count(text: string) {.thread.} =
  results.send((text, text.len))

proc main() =
  results.open()
  var worker: Thread[string]
  createThread(worker, count, "Nim")
  worker.joinThread()
  let (text, characters) = results.recv()
  echo text, " has ", characters, " characters"
  results.close()

main()
