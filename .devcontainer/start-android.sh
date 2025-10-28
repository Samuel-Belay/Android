#!/bin/bash
set -e

echo "=== Android Emulator VM starting ==="

# Create AVD if missing
if [ ! -d "$ANDROID_AVD_HOME/pixel6.avd" ]; then
    echo "Creating Pixel 6 AVD..."
    echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86" -d "pixel_6" --force
fi

# Start XFCE desktop in background
export DISPLAY=:1
Xvfb :1 -screen 0 1920x1080x24 &

# Start VNC server
vncserver :1 -geometry 1920x1080 -depth 24
echo "=== VNC Desktop started on port 5901 ==="

# Launch Android emulator with GUI
$ANDROID_SDK_ROOT/emulator/emulator \
    -avd pixel6 \
    -gpu host \
    -no-snapshot-load \
    -no-audio &

echo "=== Emulator started. Connect to VNC to interact ==="

# Keep container alive
tail -f /dev/null
