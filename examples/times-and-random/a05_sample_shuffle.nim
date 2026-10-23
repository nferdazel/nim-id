import std/random

var r = initRand(1234)

let names = @["ada", "grace", "linus", "margaret"]
echo r.sample(names)
echo r.sample(names)

var deck = @[1, 2, 3, 4, 5]
r.shuffle(deck)
echo deck
