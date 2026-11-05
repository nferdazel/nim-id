import std/options

proc findChar(s: string; c: char): Option[int] =
  for i, ch in s:
    if ch == c:
      return some(i)
  none(int)

echo findChar("nim", 'm').get
echo findChar("nim", 'z').isSome
echo findChar("nim", 'z').get(-1)
