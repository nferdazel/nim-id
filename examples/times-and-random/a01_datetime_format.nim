import std/times

let launch = dateTime(2024, mMar, 1, 9, 30, 0, 0, utc())

echo launch.format("yyyy-MM-dd HH:mm:ss")
echo launch.format("ddd d MMM yyyy")
echo launch
echo launch.hour, ":", launch.minute
