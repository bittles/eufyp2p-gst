#!/usr/bin/bash

set +e

if [ ! -d /data/eufyp2p ]; then
    mkdir /data/eufyp2p
    cp go2rtc.yaml /data/eufyp2p/
fi

while true; do
    killall python3
    killall go2rtc
    python3 hello.py &
    go2rtc -config /data/eufyp2p/go2rtc.yaml
    sleep 5
done

