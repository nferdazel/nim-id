type Point = object
  x, y: int

var p = Point(x: 1, y: 2)
p.x = 10
echo p.x, ",", p.y
