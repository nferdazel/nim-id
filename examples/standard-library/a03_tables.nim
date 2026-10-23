import std/tables

var ages = initTable[string, int]()
ages["ada"] = 36
ages["grace"] = 45

echo ages["ada"]
echo ages.hasKey("linus")
echo ages.getOrDefault("linus", -1)
echo ages.len
