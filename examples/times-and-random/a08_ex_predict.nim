import std/times

let lastDay = dateTime(2024, mDec, 31, 23, 59, 0, 0, utc())
echo lastDay + initDuration(minutes = 2)
