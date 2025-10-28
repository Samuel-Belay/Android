#!/bin/bash
set -e

# ---------- Start XFCE + VNC ----------
echo "Starting XFCE desktop on :1..."
export DISPLAY=:1
export USER_HOME=/home/vscode

# Install XFCE and VNC if not already present
if [ ! -d /usr/share/xsessions/xfce.desktop ]; then
    echo "Installing XFCE desktop..."
    sudo apt-get update
    sudo apt-get install -y xfce4 xfce4-goodies tightvncserver
    sudo apt-get clean
fi

# Start VNC server (password-less, can change for security)
if ! pgrep Xtightvnc >/dev/null; then
    echo "Starting VNC server on display :1..."
    su vscode -c "vncserver :1 -geometry 1920x1080 -depth 24 -nopw"
fi

# ---------- Start the Android emulator ----------
echo "Starting Android emulator..."
su vscode -c "$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu swiftshader_indirect -no-snapshot-load -no-audio &"

echo "=== Emulator started! Connect via VNC on port 5901 ==="

# Keep container alive
tail -f /dev/null
