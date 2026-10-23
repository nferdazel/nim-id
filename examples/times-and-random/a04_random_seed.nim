import std/random

randomize(1234)
echo rand(100)
echo rand(100)
echo rand(1.0 .. 10.0)

# A fresh generator with the same seed repeats the sequence from the start.
var r = initRand(1234)
echo r.rand(100)
echo r.rand(100)
