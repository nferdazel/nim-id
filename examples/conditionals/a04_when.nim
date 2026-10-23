when defined(windows):
  const PathSeparator = '\\'
else:
  const PathSeparator = '/'

echo "separator: ", PathSeparator
