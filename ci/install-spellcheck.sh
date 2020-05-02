#!/usr/bin/env bash

## install-spellcheck.sh: run during a CI build to install Pandoc spellcheck dependencies.

# Set options for extra caution & debugging
set -o errexit \
    -o pipefail

sudo apt-get update -y
sudo apt-get install -y aspell aspell-en
wget https://raw.githubusercontent.com/agitter/lua-filters/25066659816b0c05c52da2699bac4ab09b8ca80b/spellcheck/spellcheck.lua
