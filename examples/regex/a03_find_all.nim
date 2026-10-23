import std/re

let log = "2024-03-01 INFO ok 2024-03-02 WARN slow"

echo "dates: ", log.findAll(re"\d{4}-\d{2}-\d{2}")
echo "levels: ", log.findAll(re"\b[A-Z]{4}\b")

for word in log.findAll(re"[a-z]+"):
  echo "word: ", word
