#!/bin/bash
# Start Xvfb
Xvfb :1 -screen 0 1280x720x16 &
sleep 2

# Start VNC server
x11vnc -display :1 -nopw -forever &

# Start Android Emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu swiftshader_indirect &
echo "=== Emulator started! Connect via VNC port 5901 ==="

# Keep container alive
tail -f /dev/null
