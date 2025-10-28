# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# --- Set non-interactive mode ---
ENV DEBIAN_FRONTEND=noninteractive

# --- Create vscode user ---
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -m -s /bin/bash --uid $USER_UID --gid $USER_GID $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME

# --- Set environment variables ---
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH

# --- Install dependencies ---
RUN sudo apt-get update && sudo apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc net-tools lsof socat xfce4 xfce4-terminal \
    dbus-x11 x11-utils mesa-utils x11-xserver-utils \
    libgtk-3-0 libnss3 libxss1 libasound2 libglu1-mesa \
    && sudo apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Download Android command line tools ---
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && mv $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/ \
    && rm -rf $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools \
    && rm cmdline-tools.zip

# --- Accept licenses and install SDK packages ---
RUN yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" \
                 "platforms;android-33" \
                 "system-images;android-33;google_apis;x86_64" \
                 "emulator" \
                 "cmdline-tools;latest"

# --- Create Pixel 6 AVD ---
RUN mkdir -p /home/$USERNAME/.android/avd \
    && echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6" --force

# --- Download and install Android Studio ---
RUN wget https://dl.google.com/dl/android/studio/ide-zips/2023.2.1.16/android-studio-2023.2.1.16-linux.tar.gz -O android-studio.tar.gz \
    && sudo tar -xzf android-studio.tar.gz -C /opt/ \
    && rm android-studio.tar.gz
ENV PATH=/opt/android-studio/bin:$PATH

# --- Copy startup script ---
COPY start-android.sh /usr/local/bin/start-android.sh
RUN sudo chmod +x /usr/local/bin/start-android.sh

# --- Default workdir ---
WORKDIR /workspace
