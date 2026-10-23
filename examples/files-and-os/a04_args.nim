import std/os

echo "arguments: ", paramCount()

for i in 0 ..< paramCount():
  echo i, ": ", paramStr(i)
