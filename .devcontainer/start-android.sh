#!/bin/bash
# Start X virtual framebuffer for GUI
Xvfb :1 -screen 0 1920x1080x24 &

# Start XFCE desktop
startxfce4 &

# Start VNC server
x11vnc -display :1 -forever -nopw -listen 0.0.0.0 -shared &

# Start Android emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu host -no-snapshot-load &

echo "=== XFCE + Android Emulator started! Connect via VNC port 5901 ==="

# Keep container alive
tail -f /dev/null
