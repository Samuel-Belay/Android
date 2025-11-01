#!/bin/bash
# Downloads and installs Android command line tools
set -e

SDK_DIR=/opt/android-sdk/cmdline-tools/latest
TMP_ZIP=/tmp/cmdline-tools.zip

wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O $TMP_ZIP
unzip -q $TMP_ZIP -d $SDK_DIR
rm -f $TMP_ZIP
