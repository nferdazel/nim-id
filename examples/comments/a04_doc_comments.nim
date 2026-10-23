## Computes the area of a rectangle.
##
## The result is in the same unit as the arguments.
proc area(width, height: float): float =
  width * height

echo area(3.0, 4.0)
