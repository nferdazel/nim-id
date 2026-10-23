import std/typedthreads

var results: Channel[int]

proc square(n: int) {.thread.} =
  results.send(n * n)

proc main() =
  results.open()
  var worker: Thread[int]
  createThread(worker, square, 5)
  worker.joinThread()
  echo results.recv()
  results.close()

main()
