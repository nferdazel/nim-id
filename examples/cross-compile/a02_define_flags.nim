# `-d:symbol` sets a compile-time flag that `when` can see.
when defined(release):
  const buildKind = "release"
else:
  const buildKind = "debug"

# `{.strdefine.}` and `{.intdefine.}` read their value from `-d:name=value`.
const targetName {.strdefine.} = "host"
const workers {.intdefine.} = 1

echo "build kind: ", buildKind
echo "target name: ", targetName
echo "workers: ", workers
