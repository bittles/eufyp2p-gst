# use restreamio ubuntu gstreamer base
ARG BUILD_ARCH
FROM restreamio/gstreamer:${BUILD_ARCH}-latest-prod

# Install ffmpeg, tini (for signal handling), and other common tools for the echo source.
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ffmpeg \
        gzip \
        jq \
        psmisc \
        python3-pip \
        tar \
        tini \
        wget

# Grab GO2RTC and ngrok binaries, not sure if ngrok needed.  It's in go2rtc addon
# Versions
ARG BUILD_ARCH
ARG GO2RTC_VERSION="v1.1.0"
ARG NGROK_VERSION="v3-3.1.1"
# Set non-matching defaults to make sure they set right
ARG GO2RTC_ARCH="amd64"
ARG NGROK_ARCH_URL_SUBDIR="3uoGJrwPaSE"

RUN if [ "${BUILD_ARCH}" = "aarch64" ]; then GO2RTC_ARCH="arm64"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then GO2RTC_ARCH="amd64"; fi \
    && if [ "${BUILD_ARCH}" = "armhf" ]; then GO2RTC_ARCH="arm"; fi \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then GO2RTC_ARCH="arm"; fi \
    && wget https://github.com/AlexxIT/go2rtc/releases/download/${GO2RTC_VERSION}/go2rtc_linux_${GO2RTC_ARCH} \
    && if [ "${GO2RTC_ARCH}" = "arm64" ]; then NGROK_ARCH_URL_SUBDIR="3uoGJrwPaSE"; fi \
    && if [ "${GO2RTC_ARCH}" = "amd64" ]; then NGROK_ARCH_URL_SUBDIR="cr98VkAAe6w"; fi \
    && if [ "${GO2RTC_ARCH}" = "arm" ]; then NGROK_ARCH_URL_SUBDIR="aPXjX6QdzRS"; fi \
    && if [ "${GO2RTC_ARCH}" = "arm" ]; then NGROK_ARCH_URL_SUBDIR="aPXjX6QdzRS"; fi \
    && wget https://bin.equinox.io/a/${NGROK_ARCH_URL_SUBDIR}/ngrok-${NGROK_VERSION}-linux-${GO2RTC_ARCH}.zip \
    && mv ngrok-${NGROK_VERSION}-linux-${GO2RTC_ARCH}.zip ngrok.gz \
    && gzip -d ngrok.gz \
    && mv go2rtc_linux_${GO2RTC_ARCH} /usr/local/bin/go2rtc \
    && mv ngrok /usr/local/bin/

# Hardware Acceleration for Intel CPU for go2rtc (+50MB)
RUN if [ "${BUILD_ARCH}" = "amd64" ]; then apk add --no-cache libva-intel-driver intel-media-driver; fi
# Install aiohttp
RUN pip3 install aiohttp

WORKDIR /
COPY app/ /app
COPY config.json /app/
# Set permissions
RUN chmod a+x /usr/local/bin/* /app/run.sh
WORKDIR /app

CMD ["bash", "run.sh"]