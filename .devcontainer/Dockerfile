# ----------------------------
# Base image
# ----------------------------
FROM ubuntu:22.04

# ----------------------------
# Create vscode user and basic setup
# ----------------------------
RUN groupadd --gid 1000 vscode \
    && useradd -m -s /bin/bash --uid 1000 --gid 1000 vscode \
    && apt-get update && apt-get install -y sudo \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode
WORKDIR /home/vscode

# ----------------------------
# Install dependencies
# ----------------------------
RUN sudo apt-get update && sudo apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xfce4 xfce4-session x11vnc xvfb socat lsof net-tools \
    && sudo apt-get clean && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Install Android SDK command line tools
# ----------------------------
ENV ANDROID_SDK_ROOT=/opt/android-sdk
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && rm cmdline-tools.zip

# Add SDK tools to PATH
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH

# ----------------------------
# Accept licenses (non-interactive)
# ----------------------------
RUN yes | sdkmanager --licenses

# ----------------------------
# Install required SDK packages
# ----------------------------
RUN sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;google_apis_playstore;x86_64" \
               "emulator" \
    && rm -rf $ANDROID_SDK_ROOT/.android/cache

# ----------------------------
# Create AVD (non-interactive)
# ----------------------------
RUN mkdir -p /home/vscode/.android/avd \
    && echo "no" | avdmanager create avd \
       -n pixel6 \
       -k "system-images;android-33;google_apis_playstore;x86_64" \
       -d "pixel_6" \
       --force \
       --sdcard 512M

# ----------------------------
# Copy start script
# ----------------------------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ----------------------------
# Default entry point
# ----------------------------
ENTRYPOINT ["/usr/local/bin/start-android.sh"]
