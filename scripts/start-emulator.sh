#!/bin/bash
echo "=== Starting XFCE + Android Emulator ==="
# Start virtual framebuffer
Xvfb :0 -screen 0 1920x1080x24 &
export DISPLAY=:0

# Start XFCE session in background
startxfce4 &

# Start VNC server
x11vnc -display :0 -forever -nopw &

# Start Android emulator GUI
emulator -avd pixel6 -no-snapshot-load -gpu swiftshader_indirect -no-audio &

echo "=== Emulator running! Connect via VNC port 5901 ==="
tail -f /dev/null
