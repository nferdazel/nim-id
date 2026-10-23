type
  ShapeKind = enum
    circle, rect
  Shape = object
    case kind: ShapeKind
      of circle:
        radius: float
      of rect:
        width, height: float

let c = Shape(kind: circle, radius: 2.0)
echo c.width
