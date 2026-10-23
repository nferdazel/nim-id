import std/json

let data = """{"age": 36}""".parseJson
echo data["name"]
