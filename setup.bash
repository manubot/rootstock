#!/bin/bash
# Setup Manubot
# Based on https://github.com/manubot/rootstock/blob/main/SETUP.md
# This is designed to be run from the terminal on linux

# Stop on first error.
set -e

usage() { echo "Usage: $0 [-o <owner-string>] [-r <repo-string>]" 1>&2; exit 1; }

# Get the repo name.
while getopts o:r: flag
do
    case "${flag}" in
        o) OWNER=${OPTARG};;
        r) REPO=${OPTARG};;
    esac
done

if [ -z "${OWNER}" ] || [ -z "${REPO}" ]; then
    usage
fi

# Check Remote Repo Exists.
echo
while true
do
 read -r -p "Have you manually created https://github.com/${OWNER}/${REPO}? [y/n] " input

 case $input in
   [yY][eE][sS]|[yY])

     echo
     echo "Continuing Setup..."
     echo
     break
     ;;
  [nN][oO]|[nN])
     echo
     echo "Go to https://github.com/new and create https://github.com/${OWNER}/${REPO}"
     echo "Note: the new repo must be completely empty or the script will fail."
     echo
     exit 1
     ;;
  *)
     echo
     echo "Invalid input, try again..."
     echo
     ;;
 esac
done

# Clone manubot/rootstock
echo
echo "Cloning Rootstock..."
echo
git clone --single-branch https://github.com/manubot/rootstock.git ${REPO}
cd ${REPO}

echo
echo "Setup tracking using https..."
echo
# Configure remotes
git remote add rootstock https://github.com/manubot/rootstock.git
# Option A: Set origin URL using its web address
git remote set-url origin https://github.com/${OWNER}/${REPO}.git

git push --set-upstream origin main

# To use GitHub Actions only:
echo "Setup for GitHub Actions ONLY..."
# remove Travis CI config
git rm .travis.yml
# remove AppVeyor config
git rm .appveyor.yml
# remove ci/install.sh if using neither Travis CI nor AppVeyor
git rm ci/install.sh

# Update README
echo "Updating README..."
# Perform substitutions
sed "s/manubot\/rootstock/${OWNER}\/${REPO}/g" README.md > tmp && mv -f tmp README.md
sed "s/manubot\.github\.io\/rootstock/${OWNER}\.github\.io\/${REPO}/g" README.md > tmp && mv -f tmp README.md

echo "Committing rebrand..."
git add --update
git commit --message "Brand repo to $OWNER/$REPO"
git push origin main
echo
echo "Setup complete"
echo
echo "The new repo as been created here: $(pwd)/${REPO}"
echo
echo "A good first step is to modify content/metadata.yaml with the relevant information for your manuscript."
echo
