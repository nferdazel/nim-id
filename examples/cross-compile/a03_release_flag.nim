when defined(release):
  echo "build kind: release"
else:
  echo "build kind: debug"

when defined(danger):
  echo "danger define is set"
else:
  echo "danger define is not set"
