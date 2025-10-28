#!/bin/bash
set -e

# Start XFCE desktop in a virtual framebuffer
echo "Starting XFCE on display :1..."
Xvfb :1 -screen 0 1280x720x24 &

# Start a VNC server on top of the Xvfb display
echo "Starting VNC server on port 5901..."
x11vnc -display :1 -forever -nopw -shared &

# Give XFCE + VNC a moment to start
sleep 5

# Start the Android emulator
echo "Starting Android Emulator..."
export ANDROID_AVD_HOME=/home/vscode/.android/avd
export PATH=$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Launch emulator with GPU acceleration
emulator -avd pixel6 -no-snapshot -gpu host -no-window=false -camera-back none -camera-front none -verbose &

echo "=== Emulator started! Connect via VNC on port 5901 ==="

# Keep container alive
tail -f /dev/null
