FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero

RUN ./cerbero-uninstalled build cdparanoia

RUN cp ./data/autotools/config.guess /cerbero/build/sources/linux_arm64/cdparanoia-10.2/configure.guess && \
    cp ./data/autotools/config.sub /cerbero/build/sources/linux_arm64/cdparanoia-10.2/configure.sub
RUN ./cerbero-uninstalled build cdparanoia
#RUN ./cerbero-uninstalled package gstreamer-1.0
