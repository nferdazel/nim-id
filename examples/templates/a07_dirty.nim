template declareX() {.dirty.} =
  var x = 5

proc run() =
  declareX()
  echo x

run()
