FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero

RUN apt-get install -y cd-paranoia

RUN ./cerbero-uninstalled fetch cdparanoia
RUN ./cerbero-uninstalled build cdparanoia -s extract

RUN cp ./data/autotools/config.guess ./build/sources/linux_arm64/cdparanoia-10.2/configure.guess && \
    cp ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/configure.sub && \
    cp ./data/autotools/config.guess ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/

RUN ./cerbero-uninstalled build cdparanoia -s compile
RUN ./cerbero-uninstalled build cdparanoia
#RUN ./cerbero-uninstalled package cdparanoia
RUN ./cerbero-uninstalled package gstreamer-1.0
