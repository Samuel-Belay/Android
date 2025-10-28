# Base Ubuntu with XFCE
FROM ubuntu:22.04

# ---------- Create vscode user ----------
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH

# ---------- Install XFCE + VNC + dependencies ----------
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies x11vnc xvfb wget unzip curl git openjdk-11-jdk \
    python3 python3-pip net-tools lsof socat \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Install Android command line tools ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && mv $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/ \
    && rm -rf $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools cmdline-tools.zip

# Switch to non-root user
USER $USERNAME
WORKDIR /home/$USERNAME

# ---------- Accept licenses & install minimal SDK + emulator ----------
RUN yes | sdkmanager --licenses >/dev/null 2>&1 && \
    sdkmanager "platform-tools" "platforms;android-33" "emulator"

# ---------- Create AVD in mounted volume ----------
RUN mkdir -p /home/$USERNAME/.android/avd
RUN echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6" || true

# ---------- Copy startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

WORKDIR /workspace
