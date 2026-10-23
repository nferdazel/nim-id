import std/[tables, algorithm]

type Book = object
  title: string
  year: int

var shelf = @[
  Book(title: "Neuromancer", year: 1984),
  Book(title: "Dune", year: 1965),
  Book(title: "Emma", year: 1815),
]

var index = initTable[string, int]()
for position, book in shelf:
  index[book.title] = position

echo "rows: ", shelf.len
echo "Dune is at row ", index["Dune"]

shelf.sort(proc (a, b: Book): int = cmp(a.year, b.year))
for book in shelf:
  echo book.year, " ", book.title
