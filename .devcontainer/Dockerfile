FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc net-tools lsof socat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

WORKDIR /opt/android-sdk

# Download Android command line tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    mkdir -p cmdline-tools/latest && \
    unzip cmdline-tools.zip -d cmdline-tools/latest && \
    rm cmdline-tools.zip

# Accept licenses & install SDK components
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;google_apis;x86_64" \
               "emulator"

# Create Pixel 6 AVD non-interactively
ENV ANDROID_AVD_HOME=/opt/android-sdk/.android/avd
RUN avdmanager create avd \
    --name pixel6 \
    --package "system-images;android-33;google_apis;x86_64" \
    --device "pixel_6" \
    --force

# Copy startup script
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# Run emulator automatically
CMD ["/usr/local/bin/start-android.sh"]
