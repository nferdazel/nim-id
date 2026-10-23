type
  ShapeKind = enum
    circle, rect
  Shape = object
    case kind: ShapeKind
      of circle:
        radius: float
      of rect:
        width, height: float

proc area(s: Shape): float =
  case s.kind
  of circle:
    3.14159 * s.radius * s.radius
  of rect:
    s.width * s.height

echo area(Shape(kind: circle, radius: 2.0))
echo area(Shape(kind: rect, width: 3.0, height: 4.0))
