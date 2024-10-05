#!/bin/bash

# Remove old packages folder
if [ -d "Packages" ]; then
    rm -rf ./Packages
fi

# Install packages
wally install

if [ ! -d "Packages" ]; then
    mkdir "Packages"
fi

# Sourcemap generation
rojo sourcemap --output sourcemap.json place.project.json

# Export the types
wally-package-types --sourcemap sourcemap.json Packages/
