import std/strutils

let line = "  Ada,36,London  "

echo line.strip
echo line.strip.split(',')
echo "ada".toUpperAscii
echo "hello".startsWith("he")
echo @["a", "b", "c"].join("-")
