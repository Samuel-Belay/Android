#!/bin/bash
# ---------------------- Start VNC server ----------------------
mkdir -p ~/.vnc
Xvfb :0 -screen 0 1280x720x24 &
export DISPLAY=:0

x11vnc -forever -usepw -display :0 -shared &

# ---------------------- Start Android emulator ----------------------
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu host -no-snapshot-load &

echo "=== Emulator + VNC started! Connect via VNC port 5900 ==="

# Keep container alive
tail -f /dev/null
