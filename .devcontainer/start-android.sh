#!/bin/bash
echo "=== Starting XFCE desktop + VNC server ==="

export DISPLAY=:1
sudo dbus-uuidgen --ensure
Xvfb :1 -screen 0 1920x1080x24 &
sleep 2

xfce4-session &
sleep 2

x11vnc -display :1 -nopw -forever -shared &
sleep 2

echo "=== VNC server running on port 5901 ==="

echo "=== Starting Android Emulator: pixel6 ==="
$ANDROID_SDK_ROOT/emulator/emulator -avd pixel6 -gpu host -no-snapshot-save &

echo "=== Android Studio ready! Launch with 'studio.sh' inside container ==="

tail -f /dev/null
