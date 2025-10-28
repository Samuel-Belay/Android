#!/bin/bash

# Start a virtual display for the emulator
export DISPLAY=:0
Xvfb :0 -screen 0 1280x800x16 &

# Optional: Start KDE Plasma lightweight session (fluxbox or plasma)
fluxbox &

# Start VNC server for remote desktop access
x11vnc -display :0 -nopw -forever -rfbport 5901 &

# Launch Android emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd Pixel_4_API_33_Play \
  -noaudio -no-boot-anim -gpu swiftshader_indirect -no-snapshot-load &

echo "🚀 Emulator launched! Connect via VNC port 5901"
sleep infinity
