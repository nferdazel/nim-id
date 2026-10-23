proc strlen(s: cstring): csize_t {.importc, header: "<string.h>".}

let text = "ab\0cd"

echo text.len
echo strlen(text.cstring)
