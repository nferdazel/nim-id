import std/re

let raw = "  Ada   Lovelace  "

echo "[", raw.replace(re"\s+", " "), "]"
echo "[", raw.replace(re"^\s+|\s+$", ""), "]"

let phone = "0812-3456-7890"
echo phone.replace(re"\D", "")

# replacef understands $1, $2, ... for the capture groups.
let name = "Ada Lovelace"
echo name.replacef(re"(\w+)\s+(\w+)", "$2, $1")

# split cuts the string on every match of the pattern.
let record = "ada, 36,london"
echo record.split(re",\s*")
