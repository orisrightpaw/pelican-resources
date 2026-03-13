FROM debian:trixie-slim
WORKDIR /home/container

ENV DEBIAN_FRONTEND=noninteractive

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
    ca-certificates
RUN rm -rf /var/lib/apt/lists/*

RUN curl -o /bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x /bin/winetricks

ENV WINEDEBUG=fixme-all
ENV WINEPREFIX=/home/container/.wine
ENV WINEARCH=win64
ENV DISPLAY=:99

RUN useradd -m -d /home/container container
RUN chown container:container /home/container
USER container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]