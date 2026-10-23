import std/[asynchttpserver, asyncdispatch, httpcore]

proc handle(req: Request) {.async.} =
  req.respond(Http200, "ok")
  echo "sent"
