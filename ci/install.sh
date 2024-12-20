#!/usr/bin/env bash

## install.sh: run during an AppVeyor build to install the conda environment
## and the optional Pandoc spellcheck dependencies.

# Set options for extra caution & debugging
set -o errexit \
    -o pipefail

wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh \
  --output-document miniforge.sh
bash miniforge.sh -b -p $HOME/miniconda
source $HOME/miniconda/etc/profile.d/conda.sh
hash -r
conda config \
  --set always_yes yes \
  --set changeps1 no
mamba env create --quiet --file build/environment.yml
mamba list --name manubot
conda activate manubot

# Install Spellcheck filter for Pandoc
if [ "${SPELLCHECK:-}" = "true" ]; then
  bash ci/install-spellcheck.sh
fi
