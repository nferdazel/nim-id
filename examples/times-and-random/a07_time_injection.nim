import std/[times, unittest]

proc isWeekend(dt: DateTime): bool =
  dt.weekday in {dSat, dSun}

suite "isWeekend":
  test "Saturday is a weekend":
    check isWeekend(dateTime(2024, mApr, 6, 12, 0, 0, 0, utc()))

  test "Wednesday is not a weekend":
    check not isWeekend(dateTime(2024, mApr, 3, 12, 0, 0, 0, utc()))
