#!/bin/bash

export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH

# Start virtual display
Xvfb :1 -screen 0 1920x1080x16 &
export DISPLAY=:1

# Start VNC server
x11vnc -display :1 -N -forever -rfbport 5901 &

# Launch emulator headless
emulator -avd pixel6 -no-snapshot-load -no-window -gpu swiftshader_indirect -memory 2048 -partition-size 10240 &

echo "=== Emulator started! Connect via port 5901 ==="

# Keep container alive
wait
