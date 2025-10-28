#!/usr/bin/env bash
set -e

echo "🪄 Starting Android Emulator (Pixel 6)..."

# Start a virtual framebuffer so emulator has a display
Xvfb :0 -screen 0 1280x800x16 &

# Start VNC server to view the emulator
x11vnc -display :0 -nopw -forever -shared -rfbport 5901 &

# Export display for emulator
export DISPLAY=:0

# Start the emulator
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 \
    -no-snapshot \
    -noaudio \
    -gpu swiftshader_indirect \
    -memory 4096 \
    -partition-size 8192 \
    -writable-system \
    -no-boot-anim \
    -skin 1080x2400 &

echo "✅ Emulator launched on VNC port 5901!"
echo "👉 Connect via VNC to port 5901 (or via browser VNC if enabled)."

# Keep container alive
tail -f /dev/null
