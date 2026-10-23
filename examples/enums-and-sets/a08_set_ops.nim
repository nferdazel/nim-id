type Color = enum
  red, green, blue

let warm: set[Color] = {red}
let cool: set[Color] = {blue}
echo warm + cool
echo warm * cool
