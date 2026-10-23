import std/strutils

let csv = "alpha, beta, gamma"
let parts = csv.split(',')

echo parts.len
echo "[" & parts[1] & "]"
echo "[" & parts[1].strip & "]"
echo "[" & "  padded  ".strip & "]"
