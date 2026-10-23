import std/json

let doc = """{"name": "Ada", "age": 36, "tags": ["math", "code"]}"""
let data = parseJson(doc)

echo data["name"].getStr
echo data["age"].getInt
echo data["tags"][1].getStr
echo data.pretty
