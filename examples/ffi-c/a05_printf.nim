proc printf(format: cstring): cint {.importc, header: "<stdio.h>", varargs.}

discard printf("pi is about %.2f\n", 3.14159)
