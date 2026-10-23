type Color = enum
  red, green, blue

var palette: set[Color] = {}
palette.incl green
palette.incl blue
palette.excl blue
echo palette
