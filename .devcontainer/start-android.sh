#!/bin/bash
set -e

echo "=== Starting Android Emulator GUI ==="

# If AVD does not exist, create it
if [ ! -d "$ANDROID_AVD_HOME/pixel6.avd" ]; then
    echo "Creating Pixel 6 AVD..."
    echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86" -d "pixel_6" --force
fi

# Start X virtual framebuffer (for GUI)
Xvfb :0 -screen 0 1080x1920x24 &
export DISPLAY=:0

# Start emulator with GUI
$ANDROID_SDK_ROOT/emulator/emulator \
    -avd pixel6 \
    -gpu swiftshader_indirect \
    -no-snapshot-load \
    -no-audio &

# Start VNC server to view GUI remotely
x11vnc -display :0 -nopw -forever &

echo "=== Emulator started! Connect via VNC on port 5900 ==="

# Keep container alive
tail -f /dev/null
