# ==============================
# Android Emulator Codespace Setup (KDE + Persistent SDK)
# ==============================
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  wget unzip curl git openjdk-11-jdk python3 python3-pip xvfb x11vnc \
  tigervnc-standalone-server fluxbox dbus-x11 \
  && rm -rf /var/lib/apt/lists/*

# Set environment variables for Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools

# Create SDK directories
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest

# Download and install command line tools
RUN cd $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip && rm cmdline-tools.zip

# Accept all licenses in advance
RUN yes | sdkmanager --licenses || true

# Install necessary SDK components (with Google Play system image)
RUN sdkmanager --install "platform-tools" "emulator" \
  "platforms;android-33" \
  "system-images;android-33;google_apis_playstore;x86_64" || true

# Create a default Pixel 4 AVD
RUN echo "no" | avdmanager create avd -n Pixel_4_API_33_Play -k "system-images;android-33;google_apis_playstore;x86_64" --device pixel_4

# Expose port for VNC access
EXPOSE 5901

# Copy startup script
COPY ../start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# Start KDE Plasma with the Android Emulator on container start
CMD ["/usr/local/bin/start-android.sh"]
