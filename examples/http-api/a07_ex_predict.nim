import std/httpcore

func status(path: string): HttpCode =
  case path
  of "/ready": Http200
  else: Http404

for path in ["/ready", "/other"]:
  echo status(path).int
