import std/times

let created = parse("2024-03-01 09:30:00", "yyyy-MM-dd HH:mm:ss", utc())

echo created
echo created.format("d MMM yyyy")
echo created.monthday, " ", created.month, " ", created.year

# The same format turns a date-only string into a midnight DateTime.
let dateOnly = parse("2024-03-01", "yyyy-MM-dd", utc())
echo dateOnly.hour, ":", dateOnly.minute
