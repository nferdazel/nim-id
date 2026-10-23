proc check(item: string): bool =
  echo "checking ", item
  return false

echo "start"
if check("a") and check("b"):
  echo "both true"
echo "done"
