FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero

#COPY cdparanoia-patch/0001-configure.in-Always-use-AC_PROG_CC.patch ./recipes/cdparanoia/
RUN ./cerbero-uninstalled fetch cdparanoia
WORKDIR /root/.cache/cerbero-sources/cdparanoia-10.2
RUN tar -xzvf cdparanoia-III-10.2.src.tgz
RUN mv cdparanoia-III-10.2 /cerbero/build/sources/linux_arm64/cdparanoia-10.2
WORKDIR /cerbero
RUN cp ./data/autotools/config.guess ./build/sources/linux_arm64/cdparanoia-10.2/configure.guess
RUN cp ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/configure.sub
RUN cp ./data/autotools/config.guess ./data/autotools/config.sub ./build/sources/linux_arm64/cdparanoia-10.2/

RUN ./cerbero-uninstalled build cdparanoia
#RUN ./cerbero-uninstalled package gstreamer-1.0
