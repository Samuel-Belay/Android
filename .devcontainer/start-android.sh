#!/usr/bin/env bash
set -e

echo "=== Setting up Android Emulator ==="

# Start the virtual framebuffer for GUI
Xvfb :0 -screen 0 1920x1080x24 &

# Start VNC server for remote access
x11vnc -display :0 -nopw -listen localhost -xkb -ncache 10 -forever &

# Start the Android emulator (Pixel 6)
echo "Starting Pixel 6 emulator..."
$ANDROID_HOME/emulator/emulator -avd pixel6 -no-audio -no-snapshot -gpu swiftshader_indirect -accel off -no-boot-anim &

echo "Emulator is booting up..."
sleep 30

# Show network ports
echo "Emulator running! Connect via Codespace Port 5901 (VNC)"
tail -f /dev/null
