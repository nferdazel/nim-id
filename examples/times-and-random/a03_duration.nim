import std/times

let start = dateTime(2024, mMar, 1, 23, 30, 0, 0, utc())
let deadline = start + initDuration(hours = 2)

echo deadline
echo deadline - start
echo (deadline - start).inMinutes
echo start.toTime.toUnix
