import std/[json, os]

type Book = object
  title: string
  year: int

let shelf = @[
  Book(title: "Neuromancer", year: 1984),
  Book(title: "Dune", year: 1965),
]

var rows = newJArray()
for book in shelf:
  rows.add %*{"title": book.title, "year": book.year}

let path = getTempDir() / "nim_id_shelf.json"
writeFile(path, rows.pretty)

let loaded = parseJson(readFile(path))
echo "rows on disk: ", loaded.len
echo "first title: ", loaded[0]["title"].getStr

removeFile(path)
