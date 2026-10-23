type Color = enum
  red, green, blue

let palette: set[Color] = {red, blue}
for color in palette:
  echo color
