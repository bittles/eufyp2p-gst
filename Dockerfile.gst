FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero
SHELL ["/bin/bash"]
RUN find ./ | grep config.*
RUN cp ./data/autotools/config.guess /cerbero/build/sources/linux_arm64/cdparanoia-10.2 && \
    cp ./data/autotools/config.sub /cerbero/build/sources/linux_arm64/cdparanoia-10.2
RUN chmod -w /cerbero/build/sources/linux_arm64/cdparanoia-10.2/config.sub /cerbero/build/sources/linux_arm64/cdparanoia-10.2/config.guess
RUN ./cerbero-uninstalled build cdparanoia


#RUN ./cerbero-uninstalled package gstreamer-1.0
