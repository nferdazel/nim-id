# The compiler resolves this `when` before the program runs.
const isWindows =
  when defined(windows): true
  else: false

const isUnixLike =
  when defined(linux) or defined(macosx) or defined(freebsd) or defined(openbsd): true
  else: false

const isLinux =
  when defined(linux): true
  else: false

echo "isWindows: ", isWindows
echo "isUnixLike: ", isUnixLike
echo "hostOS agrees with defined(linux): ", (hostOS == "linux") == isLinux
echo "hostCPU is set: ", hostCPU.len > 0
