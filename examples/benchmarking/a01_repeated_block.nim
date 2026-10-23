import std/[monotimes, times]

proc sumUp(iterations: int): int =
  for i in 0 ..< iterations:
    result += i

# Warm-up: the first run pays for page faults and cold caches.
discard sumUp(10_000)

const Iterations = 200_000
let start = getMonoTime()
let checksum = sumUp(Iterations)
let elapsed = getMonoTime() - start

echo "iterations: ", Iterations
echo "checksum: ", checksum
echo "elapsed is not negative: ", elapsed.inMilliseconds >= 0
