import std/uri

let target = parseUri("/search?q=nim+lang&page=2")

echo "path: ", target.path
echo "query: ", target.query
for key, value in decodeQuery(target.query):
  echo key, " = ", value
