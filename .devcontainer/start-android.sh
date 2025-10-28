#!/bin/bash
set -e

# Start XFCE in virtual display
Xvfb :1 -screen 0 1920x1080x24 &
export DISPLAY=:1

# Start VNC server
x11vnc -display :1 -forever -nopw -shared &

# Start Android emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-load &

echo "=== Emulator started with GUI! Connect via VNC port 5901 ==="

# Keep container alive
tail -f /dev/null
