type Task = object
  title: string
  done: bool

var t = Task(title: "write")
echo t.done, " ", t.title
