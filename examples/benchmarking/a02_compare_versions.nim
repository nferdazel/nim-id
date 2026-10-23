import std/[monotimes, times]

proc byConcatenation(rounds: int): string =
  for i in 0 ..< rounds:
    result = result & "x"

proc byAppend(rounds: int): string =
  for i in 0 ..< rounds:
    result.add 'x'

const Rounds = 20_000

# Warm up both versions before the timed runs.
discard byConcatenation(100)
discard byAppend(100)

let slowStart = getMonoTime()
let slowText = byConcatenation(Rounds)
let slowMs = (getMonoTime() - slowStart).inMilliseconds

let fastStart = getMonoTime()
let fastText = byAppend(Rounds)
let fastMs = (getMonoTime() - fastStart).inMilliseconds

echo "same result: ", slowText == fastText
echo "fast <= slow: ", fastMs <= slowMs
