proc triple(x: cint): cint {.compile: "helper.c", importc.}

echo triple(14)
