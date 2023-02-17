FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero

#RUN apt-get install -y libcdparanoia-dev

#RUN ./cerbero-uninstalled fetch cdparanoia
#RUN ./cerbero-uninstalled build cdparanoia -s extract

#RUN cp ./data/autotools/config.guess ./build/sources/linux_arm64/cdparanoia-10.2/configure.guess && \
#    cp ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/configure.sub && \
#    cp ./data/autotools/config.guess ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/

#RUN ./cerbero-uninstalled build cdparanoia -s configure
#RUN ./cerbero-uninstalled build cdparanoia -s compile
#RUN ./cerbero-uninstalled build cdparanoia -s install
#RUN ./cerbero-uninstalled build cdparanoia -s post_install
#RUN ./cerbero-uninstalled build cdparanoia

COPY recipes/ ./
RUN rm -rf ./recipes/cdpara*

RUN ./cerbero-uninstalled  -v mingw package gstreamer-1.0
