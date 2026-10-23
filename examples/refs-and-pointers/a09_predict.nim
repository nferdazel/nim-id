type Point = ref object
  x, y: int

var p = Point(x: 1, y: 2)
var q = p
q.x = 10
echo p.x, " ", q.x
