import std/typedthreads

echo "threads enabled: ", compileOption("threads")

proc hello() {.thread.} =
  echo "hello from the worker"

proc main() =
  var worker: Thread[void]
  createThread(worker, hello)
  worker.joinThread()
  echo "back on the main thread"

main()
