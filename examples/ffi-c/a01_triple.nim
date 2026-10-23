{.compile: "helper.c".}

proc triple(x: cint): cint {.importc.}

echo triple(14)
