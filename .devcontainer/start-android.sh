#!/bin/bash

# Start Xvfb for headless display
Xvfb :0 -screen 0 1280x720x16 &

# Start Android emulator in headless mode
emulator -avd pixel6 -no-window -no-audio -gpu swiftshader_indirect &

echo "=== Emulator started! Connect via port 5901 ==="

# Keep container alive
tail -f /dev/null
