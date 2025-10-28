#!/bin/bash
set -e

# Start virtual framebuffer (for GUI apps)
Xvfb :1 -screen 0 1920x1080x24 &
export DISPLAY=:1

# Start VNC server
x11vnc -forever -usepw -create -display :1 &

# Launch emulator in background
emulator -avd pixel6 -no-snapshot -gpu swiftshader_indirect -no-audio -no-window &

echo "=== Emulator started! Connect via port 5901 ==="

# Keep container alive
tail -f /dev/null
