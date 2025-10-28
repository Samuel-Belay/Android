# Base image
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Install essential tools
RUN apt-get update && apt-get install -y \
    wget unzip curl git openjdk-11-jdk python3 python3-pip \
    xvfb x11vnc qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV ANDROID_HOME=/home/vscode/android-sdk
ENV PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH

USER vscode
WORKDIR /home/vscode
