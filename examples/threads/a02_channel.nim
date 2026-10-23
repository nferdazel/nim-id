import std/typedthreads

var messages: Channel[string]

proc produce() {.thread.} =
  for word in ["alpha", "beta", "gamma"]:
    messages.send(word)
  messages.send("done")

proc main() =
  messages.open()
  var worker: Thread[void]
  createThread(worker, produce)
  worker.joinThread()
  while true:
    let message = messages.recv()
    if message == "done":
      break
    echo "got: ", message
  messages.close()

main()
