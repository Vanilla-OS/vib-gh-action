#!/bin/bash

VIB_VERSION="v0.3.1"
PLUGINS_ARG="${INPUT_PLUGINS:-}"

if [ -z "$PLUGINS_ARG" ]; then
    echo "No plugins specified, using static Vib binary"
    wget "https://github.com/Vanilla-OS/Vib/releases/download/$VIB_VERSION/vib"
    chmod +x vib
else
    echo "Plugins specified, building Vib from source along with plugins"
    mkdir plugins
    mkdir vib_work

    IFS=',' read -ra PLUGIN_LIST <<< "$PLUGINS_ARG"
    for PLUGIN in "${PLUGIN_LIST[@]}"; do
        git clone "$PLUGIN" "vib_work/$(basename "$PLUGIN")"

        cd "vib_work/$(basename "$PLUGIN")"
        go get github.com/vanilla-os/vib/api
        go build -trimpath -buildmode=plugin
        mv *.so ../../plugins

        cd -
    done

    wget "https://github.com/Vanilla-OS/Vib/archive/$VIB_VERSION.tar.gz"
    tar -xzvf "$VIB_VERSION.tar.gz"

    cd "Vib-$VIB_VERSION"
    go get github.com/vanilla-os/vib/api
    go build -trimpath -o vib
    chmod +x vib
    mv vib ../

    cd -
fi