import std/strformat

let name = "Nim"
let count = 3
let ratio = 12.5

echo fmt"[{name:>6}]"
echo fmt"[{name:<6}]"
echo fmt"{count:04d}"
echo fmt"total: {ratio:8.2f}"
