import std/[monotimes, times]

proc checksum(n: int): int =
  for i in 1 .. n:
    result += i

const Repetitions = 5
var best = high(int64)
var last = 0

# Repeat the same block and keep the fastest run.
for _ in 1 .. Repetitions:
  let start = getMonoTime()
  last = checksum(50_000)
  let elapsed = (getMonoTime() - start).inMilliseconds
  if elapsed < best:
    best = elapsed

echo "repetitions: ", Repetitions
echo "checksum: ", last
echo "best is not negative: ", best >= 0
