import std/times

proc mix(rounds: int): int =
  for i in 0 ..< rounds:
    result = result xor i

let before = cpuTime()
let value = mix(100_000)
let after = cpuTime()

echo "value: ", value
echo "cpu time is not negative: ", after - before >= 0.0
echo "wall clock looks plausible: ", epochTime() > 1.0e9
