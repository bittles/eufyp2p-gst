FROM bittles999/cerbero-bootstrap-bullseye

WORKDIR /cerbero



COPY cdparanoia-patch/0001-configure.in-Always-use-AC_PROG_CC.patch ./recipes/cdparanoia/
RUN ./cerbero-uninstalled build cdparanoia


#RUN ./cerbero-uninstalled package gstreamer-1.0
