import std/[asynchttpserver, httpcore, uri]

let request = Request(reqMethod: HttpGet, url: parseUri("/items/7"))

func describe(req: Request): string =
  $req.reqMethod & " " & req.url.path

echo describe(request)
