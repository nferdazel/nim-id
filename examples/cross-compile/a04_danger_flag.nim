when defined(danger):
  echo "danger define is set"
else:
  echo "danger define is not set"

when defined(release):
  echo "release is implied by danger"
else:
  echo "release is not set"
