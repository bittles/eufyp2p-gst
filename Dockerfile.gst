FROM ghcr.io/hassio-addons/debian-base:6.2.1

ARG GST_VERSION="1.22"
ARG CERBERO_VERSION="1.22.0"

WORKDIR /
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
    git \
    python3 \
    python3-pip \
    wget

RUN git clone --depth 1 --branch ${CERBERO_VERSION} https://github.com/GStreamer/cerbero


WORKDIR ./cerbero
RUN ./cerbero-uninstalled package gstreamer-1.0