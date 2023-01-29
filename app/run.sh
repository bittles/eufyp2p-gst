#!/usr/bin/bash

set +e

if [ ! -d /config/eufyp2p ]; then
    mkdir /config/eufyp2p
    cp config/go2rtc.yaml /config/eufyp2p/
fi

if [ ! -d /config/www/eufyp2p ]; then
    mkdir -p /config/www/eufyp2p
fi

while true; do
    killall python3
    killall go2rtc
    exec python3 -m eufyp2p &
    go2rtc -config /config/eufyp2p/go2rtc.yaml
    sleep 5
done

