var seen: set[char] = {}
for c in "hello":
  seen.incl c
echo 'h' in seen
echo 'z' in seen
echo card(seen)
