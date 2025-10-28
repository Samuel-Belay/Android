#!/bin/bash
set -e

echo "=== Setting up Android SDK and Emulator ==="

mkdir -p $HOME/android-sdk
cd $HOME/android-sdk

# Download and unzip the command line tools
if [ ! -f cmdline-tools.zip ]; then
  wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip
fi
mkdir -p cmdline-tools/latest
unzip -o cmdline-tools.zip -d cmdline-tools/latest
mv cmdline-tools/latest/cmdline-tools/* cmdline-tools/latest/ 2>/dev/null || true
rmdir cmdline-tools/latest/cmdline-tools 2>/dev/null || true

# Add environment vars persistently
echo 'export ANDROID_HOME=$HOME/android-sdk' >> ~/.bashrc
echo 'export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH' >> ~/.bashrc
export ANDROID_HOME=$HOME/android-sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH

# Install SDK packages
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-33" "system-images;android-33;google_apis;x86_64" "emulator"

# Create emulator (Pixel 6)
echo "no" | avdmanager create avd -n MultiAppDevice -k "system-images;android-33;google_apis;x86_64" --device "pixel_6" --force

# Expand disk & RAM
AVD_PATH="$HOME/.android/avd/MultiAppDevice.avd"
mkdir -p "$AVD_PATH"
AVD_CONFIG="$AVD_PATH/config.ini"
grep -q "hw.ramSize" $AVD_CONFIG && sed -i 's/^hw.ramSize=.*/hw.ramSize=4096/' $AVD_CONFIG || echo "hw.ramSize=4096" >> $AVD_CONFIG
grep -q "disk.dataPartition.size" $AVD_CONFIG && sed -i 's/^disk.dataPartition.size=.*/disk.dataPartition.size=2G/' $AVD_CONFIG || echo "disk.dataPartition.size=2G" >> $AVD_CONFIG

# Launch virtual display & VNC
Xvfb :1 -screen 0 1280x720x16 &
export DISPLAY=:1
x11vnc -display :1 -nopw -listen localhost -xkb -forever &

# Start emulator
emulator -avd MultiAppDevice -no-boot-anim -gpu swiftshader_indirect -no-audio -no-snapshot &

echo "=== Emulator started! Connect via port 5901 ==="
