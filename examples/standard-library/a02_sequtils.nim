import std/sequtils

let numbers = @[1, 2, 3, 4, 5, 6]

echo numbers.filterIt(it mod 2 == 0)
echo numbers.mapIt(it * it)
echo numbers.filterIt(it > 2).mapIt(it * 10)
