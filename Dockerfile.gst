FROM ghcr.io/hassio-addons/debian-base:6.2.1

ARG GST_VERSION="1.22"
ARG CERBERO_VERSION="1.22.0"

WORKDIR /
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    autotools-dev automake autoconf libtool g++ autopoint make cmake bison flex nasm pkg-config libxv-dev libx11-dev libx11-xcb-dev libpulse-dev python3-dev gettext build-essential libxext-dev libxi-dev x11proto-record-dev libxrender-dev libgl1-mesa-dev libxfixes-dev libxdamage-dev libxcomposite-dev libasound2-dev gperf wget libxtst-dev libxrandr-dev libglu1-mesa-dev libegl1-mesa-dev git xutils-dev intltool ccache python3-setuptools libssl-dev

RUN pip3 install \
    distro

RUN git clone --depth 1 --branch ${CERBERO_VERSION} https://github.com/GStreamer/cerbero

RUN cp /usr/share/misc/config.guess /usr/share/misc/config.sub /cerbero/data/autotools

WORKDIR ./cerbero
RUN ./cerbero-uninstalled bootstrap
RUN ./cerbero-uninstalled package gstreamer-1.0
