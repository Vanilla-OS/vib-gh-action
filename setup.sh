#!/bin/bash

VIB_VERSION="0.3.1"
PLUGINS_ARG="${1:-}"

if [ -z "$PLUGINS_ARG" ]; then
    echo "No plugins specified, using static Vib binary"
    wget "https://github.com/Vanilla-OS/Vib/releases/download/v$VIB_VERSION/vib"
    chmod +x vib
else
    echo "Plugins specified, downloading plugin assets"

    mkdir plugins

    IFS=',' read -ra PLUGIN_LIST <<< "$(echo "$PLUGINS_ARG")"
    for PLUGIN in "${PLUGIN_LIST[@]}"; do
        REPO=$(echo "$PLUGIN" | awk -F':' '{print $1}')
        TAG=$(echo "$PLUGIN" | awk -F':' '{print $2}')
        
        echo "Downloading $REPO"
        wget -O "plugins/$(basename "$REPO").so" "https://github.com/$REPO/releases/download/$TAG/$(basename "$REPO").so"
    done

    wget "https://github.com/Vanilla-OS/Vib/releases/download/v$VIB_VERSION/vib"
    chmod +x vib
fi
