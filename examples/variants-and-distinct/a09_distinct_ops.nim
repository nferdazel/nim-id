type Dollars = distinct float

proc `$`(d: Dollars): string =
  $float(d) & " USD"

proc `+`(a, b: Dollars): Dollars {.borrow.}

let total = Dollars(10.0) + Dollars(5.5)
echo total
