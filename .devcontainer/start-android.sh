#!/bin/bash
# Start VNC + XFCE
export DISPLAY=:1
Xvfb :1 -screen 0 1280x720x24 &
xfce4-session &

# Start Android emulator
emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-load &

echo "=== Emulator GUI available via VNC on port 5901 ==="

# Keep container alive
tail -f /dev/null
