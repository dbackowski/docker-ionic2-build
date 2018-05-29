FROM ubuntu:16.04
MAINTAINER Damian Baćkowski <damianbackowski@gmail.com>

ENV IONIC_CLI_VERSION=3.20.0
ENV CORDOVA_VERSION=8.0.0
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_VERSION=3859397
ENV NODE_VERSION 8.11.2
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin:/opt/tools

RUN apt-get update && apt-get install software-properties-common -y && add-apt-repository ppa:webupd8team/java -y && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc && \
    apt-get update && \
    apt-get -y install unzip ruby ruby-dev build-essential patch libxslt-dev libxml2-dev zlib1g-dev curl oracle-java8-installer && \
    apt-get clean && \
    gem install google_drive && \
    curl -sSLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" && \
    tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 && \
    rm -f "node-v$NODE_VERSION-linux-x64.tar.xz" && \
    npm install npm -g && \
    npm install -g cordova@"$CORDOVA_VERSION" ionic@"$IONIC_CLI_VERSION" && \
    npm cache clear --force && \
    mkdir $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    wget "https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_VERSION.zip" && \
    unzip "sdk-tools-linux-$ANDROID_SDK_VERSION.zip" && \
    rm "sdk-tools-linux-$ANDROID_SDK_VERSION.zip" && \
    sdkmanager --update && \
    (while sleep 5; do echo "y"; done) | sdkmanager "platforms;android-27" "build-tools;27.0.3" "extras;google;m2repository" "extras;android;m2repository"
COPY tools /opt/tools
