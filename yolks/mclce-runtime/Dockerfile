FROM --platform=$TARGETOS/$TARGETARCH debian:trixie-slim

LABEL org.opencontainers.image.authors="cirro@snep.lol" 
LABEL org.opencontainers.image.source="https://github.com/pelican-eggs/yolks" 
LABEL org.opencontainers.image.licenses="AGPL-3.0" 
LABEL org.opencontainers.image.description="Minecraft: Legacy Console Edition runtime yolk for Pelican"

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get upgrade
RUN apt-get install -y --no-install-recommends \
    wine \
    wine32 \
    wine64 \
    libwine \
    libwine:i386 \
    xvfb \
    curl \
    cabextract \
    ca-certificates \
    tini
RUN rm -rf /var/lib/apt/lists/*

RUN curl -o /bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x /bin/winetricks

RUN useradd -m -d /home/container -s /bin/bash container
USER container

ENV USER=container HOME=/home/container
ENV WINEDEBUG=fixme-all
ENV WINEPREFIX=/home/container/.wine
ENV WINEARCH=win64
ENV DISPLAY=:99

WORKDIR /home/container

STOPSIGNAL SIGINT

COPY --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]