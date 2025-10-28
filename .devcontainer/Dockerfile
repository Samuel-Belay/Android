# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Set non-interactive and locale
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV TZ=Europe/London

# Android SDK location
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
ENV ANDROID_AVD_HOME=$ANDROID_SDK_ROOT/.android/avd
ENV ANDROID_EMULATOR_USE_SYSTEM_LIBS=1

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc net-tools lsof socat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and unzip command line tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    rm cmdline-tools.zip

# Accept licenses and install SDK components
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;google_apis;x86_64" \
               "emulator"

# Create Pixel 6 AVD fully non-interactive
RUN mkdir -p $ANDROID_AVD_HOME && \
    echo no | avdmanager create avd \
        --name pixel6 \
        --package "system-images;android-33;google_apis;x86_64" \
        --device "pixel_6" \
        --abi x86_64 \
        --force

# Copy startup script
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# Expose VNC port
EXPOSE 5901

# Default entrypoint
CMD ["/usr/local/bin/start-android.sh"]
