type Counter = object
  hits: int
  label: string

var c: Counter
echo c.hits, "|", repr(c.label)
