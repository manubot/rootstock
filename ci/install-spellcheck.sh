#!/usr/bin/env bash

## install-spellcheck.sh: run during a CI build to install Pandoc spellcheck dependencies.

# Set options for extra caution & debugging
set -o errexit \
    -o pipefail

# --allow-releaseinfo-change for error on appveyor like "Repository ... changed its 'Label' value"
sudo apt-get update --yes --allow-releaseinfo-change
sudo apt-get install --yes aspell aspell-en
wget --directory-prefix=build/pandoc/filters \
  https://github.com/pandoc/lua-filters/raw/13c3fa7e97206413609a48a82575cb43137e037f/spellcheck/spellcheck.lua
