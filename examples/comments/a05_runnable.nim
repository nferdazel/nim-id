proc double*(n: int): int =
  ## Doubles an integer.
  runnableExamples:
    doAssert double(2) == 4
  n * 2

echo double(21)
