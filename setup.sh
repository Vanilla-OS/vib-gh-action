#!/bin/bash

VIB_VERSION="1.0.2"
PLUGINS_ARG="${1:-}"

case "$RUNNER_ARCH" in
    X64)    ARCH="amd64" ;;
    ARM64)  ARCH="arm64" ;;
    *)      echo "Unsupported runner architecture: $RUNNER_ARCH"; exit 1 ;;
esac

echo "Detected architecture: $ARCH"

wget "https://github.com/Vanilla-OS/Vib/releases/download/v$VIB_VERSION/plugins-$ARCH.tar.gz"
tar -xf plugins-$ARCH.tar.gz
mv build/plugins plugins

if [ -z "$PLUGINS_ARG" ]; then
    echo "No plugins specified, using static Vib binary"
else
    echo "Plugins specified, downloading plugin assets..."

    IFS=',' read -ra PLUGIN_LIST <<<"$PLUGINS_ARG"
    for PLUGIN in "${PLUGIN_LIST[@]}"; do
        REPO=$(echo "$PLUGIN" | awk -F':' '{print $1}')
        TAG=$(echo "$PLUGIN" | awk -F':' '{print $2}')

        echo "Downloading assets for $REPO..."

        ASSETS_URL="https://api.github.com/repos/$REPO/releases/tags/$TAG"
        ASSET_URLS=$(curl -s "$ASSETS_URL" | grep -o -E "https://github.com/[^\"]+$ARCH[^\"]*\.so")
        if [ -z "$ASSET_URLS" ]; then
            ASSET_URLS=$(curl -s "$ASSETS_URL" | grep -o -E 'https://github.com/[^"]+\.so')
        fi

        for ASSET_URL in $ASSET_URLS; do
            wget -P plugins/ "$ASSET_URL"
        done
    done
fi

wget -O vib "https://github.com/Vanilla-OS/Vib/releases/download/v$VIB_VERSION/vib-$ARCH"
chmod +x vib
