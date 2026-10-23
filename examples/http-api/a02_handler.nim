import std/[httpcore, json]

type Reply = tuple[code: HttpCode, body: string]

proc dispatch(httpMethod: HttpMethod, path: string, body: string): Reply =
  case path
  of "/health":
    (Http200, """{"status":"ok"}""")
  of "/items":
    if httpMethod != HttpPost:
      (Http400, """{"error":"POST required"}""")
    else:
      let payload = parseJson(body)
      (Http200, $(%*{"name": payload["name"].getStr}))
  else:
    (Http404, """{"error":"not found"}""")

let requests = [
  (HttpGet, "/health", ""),
  (HttpPost, "/items", """{"name":"book"}"""),
  (HttpGet, "/items", ""),
  (HttpGet, "/missing", ""),
]

for (httpMethod, path, body) in requests:
  let reply = dispatch(httpMethod, path, body)
  echo reply.code.int, " ", reply.body
