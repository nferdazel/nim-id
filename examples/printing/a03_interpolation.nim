import std/strformat
import std/strutils

let name = "Nim"
let count = 3
let price = 12.5

echo &"{name} has {count} items"
echo &"total: {float(count) * price}"
echo &"upper: {name.toUpperAscii}"
