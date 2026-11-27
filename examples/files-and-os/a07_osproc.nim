import std/[osproc, strutils]

let cmd = execCmdEx("echo hai")

echo cmd.output.strip
echo cmd.exitCode
