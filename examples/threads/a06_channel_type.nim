import std/typedthreads

var channel: Channel[string]

proc produce() {.thread.} =
  channel.send("42")

proc main() =
  channel.open()
  var worker: Thread[void]
  createThread(worker, produce)
  worker.joinThread()
  let n: int = channel.recv()
  echo n + 1
  channel.close()

main()
