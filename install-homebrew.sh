#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is anything but empty.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------

echo
echo "Checking if Xcode Command Line Tools are installed..."
xcode-select -p

# -----------------------------------------------------------------------------

HB_PREFIX=${HB_PREFIX:-"$HOME/.local/homebrew/hb"}
export HOMEBREW_NO_EMOJI=1

brew_git_url="https://github.com/Homebrew/brew.git"
brew_git_commit_id="3.2.11"

homebrew_core_git_url="https://github.com/Homebrew/homebrew-core.git"
homebrew_core_git_commit_id="1ce3271cff8ae34b6c297c11931e92a47b9130d7"


echo "Recreating \"${HB_PREFIX}\"..."
rm -rf "${HB_PREFIX}"
mkdir -p "${HB_PREFIX}"

folder_name="$(basename "${HB_PREFIX}")"

cd "$(dirname "${HB_PREFIX}")"

echo
echo "Cloning Homebrew/brew..."
git clone ${brew_git_url} "${folder_name}"

cd "${folder_name}"
git checkout -b xbb ${brew_git_commit_id}

cd "${HB_PREFIX}"
mkdir -p Library/Taps/homebrew
cd Library/Taps/homebrew

echo
echo "Cloning Homebrew/homebrew-core..."
git clone ${homebrew_core_git_url} homebrew-core

cd homebrew-core

echo
echo "Checking out ${homebrew_core_git_commit_id}"
git checkout -b xbb ${homebrew_core_git_commit_id}

PATH="${HB_PREFIX}/bin:${PATH}"
export PATH

hash -r 

# -----------------------------------------------------------------------------

brew --version

# -----------------------------------------------------------------------------

# For general usage.
brew install minicom 
brew install tree
brew install wget


# GDB is available from the GCC instance.

# May be used by mBed.
brew install hg

brew install cvs

# -----------------------------------------------------------------------------

# To use Homebrew, add something like this to ~/.zprofile
echo alias ahb=\'export PATH=${HB_PREFIX}/bin:\${PATH}\'
