type Node = ref object
  value: int
  next: Node

var head = Node(value: 1)
head.next = Node(value: 2)
echo head.value, " -> ", head.next.value
