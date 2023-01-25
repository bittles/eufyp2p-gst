# syntax=docker/dockerfile:labs
FROM restreamio/gstreamer:aarch64-latest-prod as base

# Prepare images
#ARG NGROK_VERSION="3"
#FROM ngrok/ngrok:3-debian as ngrokimage
FROM --platform=linux/arm64 ngrok/ngrok:3-debian as ngrokimage

FROM scratch AS rootfs

COPY bin/go2rtc /usr/local/bin/
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
