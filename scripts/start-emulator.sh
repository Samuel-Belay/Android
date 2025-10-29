#!/bin/bash
set -e

vncserver -geometry 1280x800 -depth 24 :1
export DISPLAY=:1

# Launch emulator (Play Store image, smooth rendering)
$ANDROID_HOME/emulator/emulator -avd play_avd \
  -no-snapshot \
  -no-audio \
  -gpu swiftshader_indirect \
  -netdelay none \
  -netspeed full \
  -memory 2048 &
  
sleep 25

# Keep container alive
tail -f /dev/null
