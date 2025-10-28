#!/bin/bash
# Start virtual display for emulator
Xvfb :1 -screen 0 1920x1080x24 &

export DISPLAY=:1

# Start emulator in the background
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -no-audio -no-window &

echo "=== Emulator started! Connect via port 5901 ==="

# Keep container alive
tail -f /dev/null
