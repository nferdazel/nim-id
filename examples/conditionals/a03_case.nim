proc season(month: int): string =
  case month
  of 12, 1, 2: "winter"
  of 3 .. 5: "spring"
  of 6 .. 8: "summer"
  of 9 .. 11: "autumn"
  else: "unknown"

for month in [1, 4, 7, 10, 13]:
  echo month, ": ", season(month)
