#!/bin/bash
set -e

SDK_DIR=$ANDROID_SDK_ROOT/cmdline-tools/latest

# Only download if not already present
if [ ! -f "$SDK_DIR/bin/sdkmanager" ]; then
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O /tmp/cmdline-tools.zip
    unzip /tmp/cmdline-tools.zip -d $SDK_DIR
    rm /tmp/cmdline-tools.zip
fi
