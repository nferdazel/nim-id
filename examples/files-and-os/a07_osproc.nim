import std/[osproc, strutils]

let hasil = execCmdEx("echo hai")

echo hasil.output.strip
echo hasil.exitCode
