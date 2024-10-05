#!/bin/bash

# Remove old packages folder
if [ -d "Build" ]; then
    rm -rf Build
fi

# Create the Build directory if it doesn't exist
if [ ! -d "Build" ]; then
    mkdir Build
fi

# Build generation
rojo build --output Build/Main.rbxl
start Build/Main.rbxl