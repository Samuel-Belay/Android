# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH

# ---------- Install dependencies ----------
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc net-tools lsof socat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Download Android command line tools ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/ && \
    rm -rf $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools && \
    rm cmdline-tools.zip

# ---------- Accept licenses and install SDK packages ----------
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;google_apis;x86_64" \
               "emulator"

# ---------- Create Pixel 6 AVD ----------
RUN echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6"

# ---------- Copy startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ---------- Default workdir ----------
WORKDIR /workspace
