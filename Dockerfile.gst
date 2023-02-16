FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero



#RUN mkdir -p ./build/sources/linux_arm64/cdparanoia-10.2
RUN cp ./data/autotools/config.guess ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2
RUN cp ./data/autotools/config.guess ./data/autotools/config.sub ./build
RUN chmod -w ./build/sources/linux_arm64/cdparanoia-10.2/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/config.guess ./build/sources/linux_arm64/cdparanoia-10.2/configure.sub ./build/sources/linux_arm64/cdparanoia-10.2/configure.guess
RUN ./cerbero-uninstalled build cdparanoia


#RUN ./cerbero-uninstalled package gstreamer-1.0
