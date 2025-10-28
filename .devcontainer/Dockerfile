# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Create vscode user (UID/GID Codespaces expects)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH
ENV AVD_NAME=pixel6

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
RUN yes | sdkmanager --licenses >/dev/null 2>&1 && \
    sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;default;x86" \
               "emulator"

# ---------- Create AVD ----------
RUN mkdir -p /home/$USERNAME/.android/avd && \
    echo "no" | avdmanager create avd -n $AVD_NAME -k "system-images;android-33;default;x86" -d "pixel_6"

# ---------- Copy startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ---------- Default workdir ----------
WORKDIR /workspace
