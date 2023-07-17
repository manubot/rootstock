#!/bin/bash
# Setup Manubot
# Based on https://github.com/manubot/rootstock/blob/main/SETUP.md
# This is designed to be run from the bash terminal

# Stop on first error.
set -e

usage() {
echo "Usage: $0 [--owner text] [--repo text] [--yes]"
echo "Guides the user through the creation of a new Manubot repository for their manuscript."
echo
echo "If no options are supplied a fully interactive process is used."
echo "OWNER and REPO refer to the details of your manuscript repo location:"
echo "i.e. https://github.com/OWNER/REPO."
echo
echo "Options:"
echo "  -o --owner   GitHub user or organization name."
echo "  -r --repo    Name of the repository for your new manuscript."
echo "  -y --yes     Non-interactive mode. Continue script without asking for confirmation that the repo exists."
echo "  -s --ssh     Use SSH to authenticate GitHub account. HTTPS is used by default."
echo "               Option only effective if --yes is also set, otherwise answer given in user interaction takes precedence."
echo "  -h --help    Display usage information."
1>&2; exit 1; }

# Check if to continue
check(){
while true
do
 echo "Once you have created your repo press enter to continue setup,"
 read -r -p "or type exit to quit now: " input

 case $input in
   "")
     echo
     echo "Continuing Setup..."
     echo
     break
     ;;
  [eE][xX][iI][tT])
     exit 1
     ;;
  *)
     echo
     echo "Invalid input, try again..."
     echo
     ;;
 esac
done
}

# Option strings
SHORT=o:r:hys
LONG=owner:,repo:,help,yes,ssh

YES=0  # continue when prompted
AUTH=0 # used https or ssh auth

# read the options
OPTS=$(getopt --options $SHORT --long $LONG --name "$0" -- "$@")

if [ $? != 0 ] ; then echo "Failed to parse options...exiting." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

# extract options and their arguments into variables.
while true ; do
  case "$1" in
    -o | --owner )
      shift;
      OWNER=$1
      shift
      ;;
    -r | --repo )
      REPO="$2"
      shift 2
      ;;
    -y | --yes )
      YES=1
      shift
      ;;
    -s | --ssh )
      AUTH=1;
      shift
      ;;
    -- )
      shift
      break
      ;;
    -h | --help )
      shift
      usage
      exit 1
      ;;
    *)
      echo "Internal error!"
      exit 1
      ;;
  esac
done

if [ -z "${OWNER}" ] || [ -z "${REPO}" ]; then
  echo "This script will take you through the setup process for Manubot."
  echo "First, we need to specify where to create the GitHub repo for your manuscript."
  echo
  echo "The URL will take this format: https://github.com/OWNER/REPO."
  echo "OWNER is your username or organization"
  echo "REPO is the name of your repository"
  echo
  read -r -p "Type in the OWNER now:" input
  OWNER=$input
  read -r -p "Type in the REPO now:" input
  REPO=$input
fi

# If using interactive mode, check remote repo exists.
if [[ "$YES" == '0' ]]; then
  while true
  do
   echo
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
       check
       break
       ;;
    *)
       echo
       echo "Invalid input, try again..."
       echo
       ;;
   esac
  done
else
  echo "Setting up https://github.com/${OWNER}/${REPO}"
fi

# Clone manubot/rootstock
echo
echo "Cloning Rootstock..."
echo
git clone --single-branch https://github.com/manubot/rootstock.git ${REPO}
cd ${REPO}

echo
echo "Setup tracking of remote..."

# Configure remotes
git remote add rootstock https://github.com/manubot/rootstock.git

# Check auth method
if [[ "$YES" == '0' ]]; then
  while true
  do
   echo
   read -r -p "Would you like to use SSH to authenticate your GitHub account? [y/n] " input

   case $input in
     [yY][eE][sS]|[yY])
       AUTH=1
       break
       ;;
    [nN][oO]|[nN])
       AUTH=0
       break
       ;;
    *)
       echo
       echo "Invalid input, try again..."
       echo
       ;;
   esac
  done
fi

case $AUTH in
  0)
  echo
  echo "Setting origin URL using its https web address"
  echo
  git remote set-url origin https://github.com/${OWNER}/${REPO}.git
  ;;
  1)
  echo
  echo "Setting origin URL using SSH"
  echo
  git remote set-url origin git@github.com:$OWNER/$REPO.git
  ;;
esac

git push --set-upstream origin main

# To use GitHub Actions only:
echo "Setup for GitHub Actions ONLY..."
# remove AppVeyor config
git rm .appveyor.yml
# remove ci/install.sh (only used by AppVeyor)
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
echo "The new repo has been created at $(pwd)"
echo
echo "A good first step is to modify content/metadata.yaml with the relevant information for your manuscript."
echo
