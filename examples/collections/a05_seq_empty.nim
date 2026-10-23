var squares: seq[int] = @[]

for i in 1 .. 4:
  squares.add(i * i)

echo squares
echo "len: ", squares.len
