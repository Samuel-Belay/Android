# Base image
FROM ubuntu:22.04

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH
ENV AVD_NAME=pixel6

# Create vscode user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ---------- Install dependencies ----------
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xfce4 xfce4-goodies \
    tightvncserver xvfb x11vnc socat net-tools lsof \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Install Android command line tools ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/ && \
    rm -rf $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools && \
    rm cmdline-tools.zip

# ---------- Accept licenses & install SDK packages ----------
RUN yes | sdkmanager --licenses >/dev/null 2>&1 && \
    sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;google_apis;x86_64" \
               "emulator"

# ---------- Create AVD silently ----------
RUN mkdir -p /home/vscode/.android/avd && \
    echo "no" | avdmanager create avd -n $AVD_NAME -k "system-images;android-33;google_apis;x86_64" -d "pixel_6" >/dev/null 2>&1

# ---------- Copy startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# Working directory
WORKDIR /workspace

# Switch to vscode user
USER $USERNAME

# Default command
CMD ["/usr/local/bin/start-android.sh"]
