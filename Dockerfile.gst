FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero
RUN cp ./data/autotools/config.guess /cerbero/build/sources/linux_arm64/cdparanoia-10.2/config.guess && \
    cp ./data/autotools/config.sub /cerbero/build/sources/linux_arm64/cdparanoia-10.2/config.sub
RUN chmod -w /cerbero/build/sources/linux_arm64/cdparanoia-10.2/config.sub /cerbero/build/sources/linux_arm64/cdparanoia-10.2/config.guess
RUN ./cerbero-uninstalled build cdparanoia


#RUN ./cerbero-uninstalled package gstreamer-1.0
