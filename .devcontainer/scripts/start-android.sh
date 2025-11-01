#!/bin/bash
# Start Android emulator in headless mode
set -e

# Start Xvfb for headless GUI
Xvfb :1 -screen 0 1080x1920x24 &
export DISPLAY=:1

# Start VNC server
x11vnc -display :1 -forever -nopw -shared &

# Start emulator
~/Android/Sdk/emulator/emulator -avd pixel6 -no-snapshot-load -no-window -gpu swiftshader_indirect
