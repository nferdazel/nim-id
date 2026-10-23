import std/typedthreads

var channel: Channel[int]

proc addOne(a: int) {.thread.} =
  channel.send(a + 1)

proc main() =
  channel.open()
  var worker: Thread[int]
  createThread(worker, addOne, 41)
  worker.joinThread()
  echo channel.recv()
  channel.close()

main()
