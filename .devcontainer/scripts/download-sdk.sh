#!/bin/bash
set -e

mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest

cd /tmp
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip
unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest
rm cmdline-tools.zip
