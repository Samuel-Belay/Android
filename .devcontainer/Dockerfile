# ---------------------- Base image ----------------------
FROM ubuntu:22.04

# ---------------------- Create vscode user ----------------------
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update && apt-get install -y sudo \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# ---------------------- Environment ----------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$PATH
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ---------------------- Install dependencies ----------------------
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc xfce4 xfce4-terminal net-tools lsof socat dbus-x11 \
    mesa-utils pulseaudio \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ---------------------- Android command line tools ----------------------
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip \
    && unzip cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools/latest \
    && mv $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/ \
    && rm -rf $ANDROID_SDK_ROOT/cmdline-tools/latest/cmdline-tools \
    && rm cmdline-tools.zip

# ---------------------- Accept licenses & install SDK ----------------------
RUN yes | sdkmanager --licenses \
    && yes | sdkmanager "platform-tools" \
                     "platforms;android-33" \
                     "system-images;android-33;google_apis;x86_64" \
                     "emulator"

# ---------------------- Create Pixel 6 AVD ----------------------
RUN mkdir -p /home/vscode/.android/avd \
    && echo "no" | avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64" -d "pixel_6"

# ---------------------- Copy startup script ----------------------
COPY start-android.sh /usr/local/bin/start-android.sh
RUN chmod +x /usr/local/bin/start-android.sh

# ---------------------- Workdir ----------------------
WORKDIR /workspace

# ---------------------- Entrypoint ----------------------
USER $USERNAME
ENTRYPOINT ["/usr/local/bin/start-android.sh"]
