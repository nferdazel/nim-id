var numbers = @[10, 20, 30, 40]

numbers.insert(15, 1)
echo "after insert: ", numbers

numbers.delete(2)
echo "after delete: ", numbers

echo "first: ", numbers[0], " last: ", numbers[^1]
