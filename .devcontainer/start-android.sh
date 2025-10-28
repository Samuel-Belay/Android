#!/bin/bash
set -e

# ------------------ Start XFCE + VNC ------------------
echo "Starting XFCE + VNC..."
mkdir -p ~/.vnc
x11vnc -storepasswd 1234 ~/.vnc/passwd
Xvfb :1 -screen 0 1920x1080x24 &
sleep 2
startxfce4 &

# ------------------ PulseAudio ------------------
pulseaudio --start

# ------------------ Create AVD if not exists ------------------
AVD_NAME=pixel6
if [ ! -d "$HOME/.android/avd/${AVD_NAME}.avd" ]; then
    echo "Creating Android AVD: $AVD_NAME"
    mkdir -p $HOME/.android/avd
    echo "no" | avdmanager create avd -n $AVD_NAME -k "system-images;android-33;google_apis;x86_64" -d "pixel_6"
fi

# ------------------ Launch emulator ------------------
echo "Starting Android emulator: $AVD_NAME"
emulator -avd $AVD_NAME -no-snapshot-load -no-audio -gpu swiftshader_indirect &

echo "=== Emulator started! Connect via VNC on port 5901 (password: 1234) ==="

# ------------------ Keep container alive ------------------
tail -f /dev/null
