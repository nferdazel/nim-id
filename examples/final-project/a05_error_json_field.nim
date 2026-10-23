import std/json

let note = %*{"text": "buy milk"}

# A JsonNode is not an object with named fields.
echo note.text
