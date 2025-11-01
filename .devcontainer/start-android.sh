#!/bin/bash
# ----------------------------
# Start Xvfb + VNC for GUI
# ----------------------------
Xvfb :1 -screen 0 1280x720x24 &
export DISPLAY=:1
x11vnc -display :1 -N -forever -shared &

# ----------------------------
# Start Android Emulator
# ----------------------------
$ANDROID_SDK_ROOT/emulator/emulator \
    -avd pixel6 \
    -no-snapshot-save \
    -noaudio \
    -no-boot-anim \
    -gpu swiftshader_indirect \
    -netfast
