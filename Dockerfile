# syntax=docker/dockerfile:labs

# Versions
ARG NGROK_VERSION="3"
ARG GO2RTC_VERSION="1.01"

# use gstreamer base
FROM restreamio/gstreamer:aarch64-latest-prod as base

# Prepare images
FROM --platform=linux/arm64 ngrok/ngrok:${NGROK_VERSION}-debian as ngrokimage

FROM scratch AS rootfs

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        wget

RUN wget https://github.com/AlexxIT/go2rtc/releases/download/${GO2RTC_VERSION}/go2rtc_linux_arm64
RUN mv go2rtc_linux_arm64 /usr/local/bin/go2rtc

#COPY bin/go2rtc /usr/local/bin/
RUN chmod a+x /usr/local/bin/go2rtc

COPY --from=ngrokimage /bin/ngrok /usr/local/bin/


# Final image
FROM base

# Install ffmpeg, tini (for signal handling),
# and other common tools for the echo source.

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        tini \
        ffmpeg \
        curl \
        jq \
        python3-pip \
        psmisc

RUN pip install aiohttp asyncio

COPY --from=rootfs / /

WORKDIR /
RUN mkdir app
COPY app/ /app/

WORKDIR /app

CMD ["bash", "run.sh"]
