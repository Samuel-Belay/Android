# ---------- Base image ----------
FROM ubuntu:22.04

# ---------- Install dependencies ----------
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc net-tools lsof socat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------- Set environment variables ----------
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools

# ---------- Download Android SDK command-line tools ----------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest
WORKDIR $ANDROID_SDK_ROOT
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip -d cmdline-tools/latest && rm cmdline-tools.zip

# ---------- Install SDK packages ----------
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" \
               "platforms;android-33" \
               "system-images;android-33;google_apis;x86_64" \
               "emulator"

# ---------- Create AVD (Pixel 6) ----------
RUN echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6"

# ---------- Copy startup script ----------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ---------- Expose emulator VNC port ----------
EXPOSE 5901

# ---------- Default startup ----------
CMD ["/usr/local/bin/start-android.sh"]
