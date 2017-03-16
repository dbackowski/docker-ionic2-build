FROM node:6.10.0
MAINTAINER Damian Baćkowski <damianbackowski@gmail.com>

ENV IONIC_VERSION=2.2.0
ENV CORDOVA_VERSION=6.5.0
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_VERSION=25.2.3
ENV PATH ${PATH}:${ANDROID_HOME}/tools

RUN apt-get update && \
    apt-get install -y openjdk-7-jdk unzip && \
    apt-get clean && \
    npm install -g cordova@"$CORDOVA_VERSION" ionic@"$IONIC_VERSION" && \
    npm cache clear && \
    mkdir $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    wget --quiet "https://dl.google.com/android/repository/tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    unzip "tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    rm "tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    (while sleep 3; do echo "y"; done) | android update sdk --all --no-ui --filter platform-tools,tools,build-tools-25.2.5,android-25,extra-android-support,extra-android-m2repository,extra-google-m2repository