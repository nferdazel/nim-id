proc box(width: int, height: int): string =
  $width & "x" & $height

echo box(width = 3, height = 4)
echo box(height = 4, width = 3)
