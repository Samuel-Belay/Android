#!/bin/bash
set -e

# Start XFCE in background
export DISPLAY=:1
Xvfb :1 -screen 0 1280x720x24 &
sleep 2
xfce4-session &
x11vnc -display :1 -nopw -forever &

# Create AVD if missing
if [ ! -d "$HOME/.android/avd/pixel6.avd" ]; then
    echo "Creating Pixel 6 AVD..."
    echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6"
fi

# Launch emulator
emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-load &
echo "=== Emulator started! Connect via VNC on port 5901 ==="

# Keep container alive
tail -f /dev/null
