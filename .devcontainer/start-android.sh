#!/bin/bash
set -e

echo "Starting XFCE desktop on :1..."
export DISPLAY=:1
export USER_HOME=/home/vscode

# Start VNC server
if ! pgrep Xtightvnc >/dev/null; then
    echo "Starting VNC server on display :1..."
    vncserver :1 -geometry 1920x1080 -depth 24 -nopw
fi

# Start Android emulator
echo "Starting Pixel 6 emulator..."
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-load -no-audio &

echo "=== Emulator started! Connect via VNC on port 5901 ==="

# Keep container alive
tail -f /dev/null
