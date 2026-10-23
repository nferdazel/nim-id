var message = "hello"
let show = proc(): string = message

message = "changed"
echo show()
