import std/sequtils

let xs = @[3, 1, 2]
echo xs.filterIt(it > 1).mapIt(it * 2)
