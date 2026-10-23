proc greet*(name: string): string =
  "Hello, " & name

const version* = "1.0"

when isMainModule:
  echo greet("Nim")
