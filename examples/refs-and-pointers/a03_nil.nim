type Node = ref object
  value: int

var a: Node
echo a.isNil

a = Node(value: 7)
echo a.isNil
echo a.value
