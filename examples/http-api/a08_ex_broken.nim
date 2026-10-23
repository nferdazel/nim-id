import std/[asynchttpserver, asyncdispatch, httpcore]

proc handle(req: Request) {.async.} =
  await req.respond("ok", Http200)
