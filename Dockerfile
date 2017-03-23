FROM ubuntu:16.04
MAINTAINER Damian Baćkowski <damianbackowski@gmail.com>

ENV IONIC_VERSION=2.2.0
ENV CORDOVA_VERSION=6.5.0
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_VERSION=25.2.3
ENV NODE_VERSION 6.10.0
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:/opt/tools

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
    npm install -g cordova@"$CORDOVA_VERSION" ionic@"$IONIC_VERSION" && \
    npm cache clear && \
    mkdir $ANDROID_HOME && \
    cd $ANDROID_HOME && \
    wget "https://dl.google.com/android/repository/tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    unzip "tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    rm "tools_r$ANDROID_SDK_VERSION-linux.zip" && \
    (while sleep 3; do echo "y"; done) | android update sdk --all --no-ui --filter platform-tools,tools,build-tools-25.0.2,android-25,extra-android-support,extra-android-m2repository,extra-google-m2repository

COPY tools /opt/tools
