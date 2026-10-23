import std/httpcore

var headers = newHttpHeaders()
headers["Content-Type"] = "application/json"

echo Http200
echo Http404
echo HttpGet
echo headers["Content-Type"]
