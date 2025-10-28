#!/bin/bash
set -e

# Start Xvfb for GUI support if needed
if ! pgrep Xvfb >/dev/null; then
    echo "Starting virtual X server..."
    Xvfb :0 -screen 0 1920x1080x24 &
    export DISPLAY=:0
fi

# Ensure emulator directories exist
mkdir -p $HOME/.android/avd
mkdir -p $ANDROID_SDK_ROOT/emulator

# Create Pixel 6 AVD if not already present
if [ ! -f "$HOME/.android/avd/pixel6.ini" ]; then
    echo "Creating Pixel 6 AVD..."
    echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6"
fi

# Start the emulator (GUI mode)
echo "Starting Pixel 6 emulator..."
$ANDROID_SDK_ROOT/emulator/emulator \
    -avd pixel6 \
    -gpu host \
    -no-snapshot-load &

echo "=== Emulator started! Connect via VNC or GUI ==="

# Keep container alive
tail -f /dev/null
