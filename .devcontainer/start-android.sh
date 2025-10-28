#!/bin/bash
# Start XFCE desktop + VNC + Android emulator

# VNC setup
export DISPLAY=:1
vncserver $DISPLAY -geometry 1920x1080 -depth 24 -name codespace-desktop

# Start XFCE in background
startxfce4 &

# Give some time for desktop to start
sleep 5

# Launch Pixel 6 emulator
emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-load &

echo "=== XFCE + Android Emulator started! Connect via VNC port 5901 ==="

# Keep container alive
tail -f /dev/null
