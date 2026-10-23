import std/[monotimes, times]

let elapsed = getMonoTime() - getMonoTime()
echo elapsed.inMilliseconds

# epochTime returns a float, not a Duration.
echo inMilliseconds(epochTime())
