#!/usr/bin/bash

set +e

if [ ! -d /data/config ]; then
    mkdir /data/config
    cp config/go2rtc.yaml /data/config/
fi

if [ ! -d /config/www/eufyp2p ]; then
    mkdir -p /config/www/eufyp2p
fi

while true; do
    killall python3
    killall go2rtc
    python3 hello.py &
    go2rtc -config /data/config/go2rtc.yaml
    sleep 5
done

