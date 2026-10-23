template swap(a, b: untyped) =
  let tmp = a
  a = b
  b = tmp

var tmp = 100
var p = 1
var q = 2
swap(p, q)
echo p, " ", q, " ", tmp
