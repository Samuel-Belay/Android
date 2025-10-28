#!/bin/bash
set -e

# ---------- Start XFCE in virtual framebuffer ----------
echo "Starting XFCE4..."
export DISPLAY=:1
Xvfb :1 -screen 0 1920x1080x24 &

# ---------- Start VNC server ----------
echo "Starting VNC server on :5901..."
x11vnc -display :1 -forever -nopw -shared &

# ---------- Start Android Emulator ----------
echo "Starting Android emulator..."
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-save &

echo "=== Emulator started! Connect via VNC to port 5901 ==="

# Keep container alive
tail -f /dev/null
