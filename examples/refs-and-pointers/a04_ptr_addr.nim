var x = 42
var p: ptr int = addr x

echo p[]
p[] = 100
echo x
