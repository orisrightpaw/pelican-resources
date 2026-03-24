#!/bin/bash

Xvfb "$DISPLAY" -ac -screen 0 64x64x24 -nolisten unix &
XVFB_PROC=$!
sleep 1

if [ ! -f /home/container/.wine/installed ]; then
    echo "Installing dotnet10 to $WINE_PREFIX"
    winetricks --unattended --force cmd dotnet10 corefonts
    touch /home/container/.wine/installed
fi

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")
printf "\033[1m\033[33mcontainer@pelican~ \033[0m%s\n" "$PARSED"
exec env ${PARSED}

echo "Killing Xvfb..."
kill -9 $XVFB_PROC
rm /tmp/.X99-lock
