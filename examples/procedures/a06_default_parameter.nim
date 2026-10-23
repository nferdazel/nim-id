proc greet(name: string, greeting = "Hello"): string =
  greeting & ", " & name

echo greet("Ada")
echo greet("Ada", "Hi")
