import std/[json, algorithm]

let rows = parseJson("""
[
  {"title": "Dune", "year": 1965},
  {"title": "Emma", "year": 1815},
  {"title": "Neuromancer", "year": 1984}
]
""")

type Match = tuple[year: int, title: string]

var result: seq[Match]
for row in rows:
  if row["year"].getInt >= 1900:
    result.add (row["year"].getInt, row["title"].getStr)

result.sort(proc (a, b: Match): int = cmp(a.year, b.year))
for item in result:
  echo item.year, " ", item.title
