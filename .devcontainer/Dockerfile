FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH

# --- Base tools ---
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies tightvncserver xterm wget unzip openjdk-17-jdk \
    libvirt-daemon-system qemu-kvm libglu1-mesa mesa-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# --- Android SDK setup ---
RUN mkdir -p $ANDROID_HOME/cmdline-tools && cd $ANDROID_HOME/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O tools.zip && \
    unzip tools.zip && rm tools.zip && mv cmdline-tools latest

# --- Accept licenses & install required components ---
RUN yes | sdkmanager --licenses || true && \
    sdkmanager "platform-tools" \
               "emulator" \
               "platforms;android-34" \
               "system-images;android-34;google_apis_playstore;x86_64"

# --- Create Play Store compatible AVD ---
RUN echo "no" | avdmanager create avd -n play_avd -k "system-images;android-34;google_apis_playstore;x86_64" --device "pixel"

# --- VNC setup ---
RUN mkdir -p /root/.vnc && \
    echo "android" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

# --- Copy scripts ---
COPY scripts /scripts
RUN chmod +x /scripts/*.sh

EXPOSE 5901
CMD ["/scripts/start-emulator.sh"]
