#!/bin/bash
set -e

# Start virtual framebuffer for GUI
Xvfb :1 -screen 0 1920x1080x24 &
export DISPLAY=:1

# Start VNC server
x11vnc -display :1 -forever -shared -nopw &

# Start Android emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -no-snapshot-load -gpu swiftshader_indirect -no-audio
