type
  Card = object
    points: int
  CardRef = ref object
    points: int

var a = Card(points: 1)
var b = a
b.points = 99
echo "value: ", a.points, " ", b.points

var c = CardRef(points: 1)
var d = c
d.points = 99
echo "ref:   ", c.points, " ", d.points
