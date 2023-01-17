#!/usr/bin/env bash

## install-manuscript-editor.sh: TODO

# Set options for extra caution & debugging
set -o errexit \
    -o pipefail

pip install -U manubot-ai-editor
