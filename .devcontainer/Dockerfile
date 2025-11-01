# ---------- Base image ----------
FROM ubuntu:22.04

# ---------- User ----------
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -m -s /bin/bash --uid $USER_UID --gid $USER_GID $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME

# ---------- Env ----------
ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH
ENV DISPLAY=:1

# ---------- Dependencies ----------
RUN sudo apt-get update && sudo apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xfce4 xfce4-session x11vnc xvfb socat lsof net-tools && \
    sudo apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Android SDK ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    rm cmdline-tools.zip

# ---------- Accept licenses ----------
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses

# ---------- Install only needed SDK packages ----------
RUN $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "platform-tools" \
    "platforms;android-33" \
    "system-images;android-33;google_apis_playstore;x86_64" \
    "emulator" && \
    rm -rf $ANDROID_SDK_ROOT/.android/cache

# ---------- Create AVD ----------
RUN mkdir -p /home/$USERNAME/.android/avd && \
    echo "no" | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis_playstore;x86_64" -d "pixel_6"

# ---------- Startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ---------- Workdir ----------
WORKDIR /workspace
