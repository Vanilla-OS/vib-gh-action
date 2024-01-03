#!/bin/bash

VIB_VERSION="v0.3.1"
PLUGINS_ARG="${INPUT_PLUGINS:-}"

if [ -z "$PLUGINS_ARG" ]; then
    echo "No plugins specified, using static Vib binary"
    wget "https://github.com/Vanilla-OS/Vib/releases/download/$VIB_VERSION/vib"
    chmod +x vib
else
    echo "Plugins specified, building Vib from source along with plugins"
    echo "Setting up Go environment"
    wget https://dl.google.com/go/go1.21.5.linux-amd64.tar.gz -O go.tar.gz
    tar -C $HOME -xzf go.tar.gz && rm go.tar.gz
    mv $HOME/go $HOME/_go
    export GOROOT=$HOME/_go
    export GO_BIN=$GOROOT/bin

    mkdir plugins
    mkdir vib_work

    IFS=',' read -ra PLUGIN_LIST <<< "$(echo "$PLUGINS_ARG")"
    for PLUGIN in "${PLUGIN_LIST[@]}"; do
        git clone "$PLUGIN" "vib_work/$(basename "$PLUGIN")"

        cd "vib_work/$(basename "$PLUGIN")"
        $GO_BIN get github.com/vanilla-os/vib/api
        $GO_BIN build -trimpath -buildmode=plugin
        mv *.so ../../plugins

        cd -
    done

    wget "https://github.com/Vanilla-OS/Vib/archive/$VIB_VERSION.tar.gz"
    tar -xzvf "$VIB_VERSION.tar.gz"

    cd "Vib-$VIB_VERSION"
    $GO_BIN get github.com/vanilla-os/vib/api
    $GO_BIN build -trimpath -o vib
    chmod +x vib
    mv vib ../

    cd -
    rm -rf "Vib-$VIB_VERSION"
    rm -rf vib_work
    unset GO_BIN
    unset GOROOT
    rm -rf $HOME/_go
fi