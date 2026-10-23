import std/[asynchttpserver, asyncdispatch, httpcore, uri]

func dispatch(httpMethod: HttpMethod, path: string,
              body: string): tuple[code: HttpCode, body: string] =
  case path
  of "/health":
    (Http200, """{"status":"ok"}""")
  else:
    (Http404, """{"error":"not found"}""")

proc handle(req: Request): Future[void] {.async.} =
  let (code, body) = dispatch(req.reqMethod, req.url.path, req.body)
  let headers = newHttpHeaders({"Content-Type": "application/json"})
  await req.respond(code, body, headers)

proc main() {.async.} =
  let server = newAsyncHttpServer()
  await server.serve(Port(8080), handle)

# The real program ends by starting the event loop: waitFor main()
for (httpMethod, path) in [(HttpGet, "/health"), (HttpGet, "/nope")]:
  let reply = dispatch(httpMethod, path, "")
  echo reply.code.int, " ", reply.body
