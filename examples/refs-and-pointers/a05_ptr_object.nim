type Counter = object
  hits: int

var c = Counter(hits: 0)
var pc = addr c

pc[].hits = 3
echo c.hits
