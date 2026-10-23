proc strlen(s: cstring): csize_t {.importc, header: "<string.h>".}

echo strlen("hello")
