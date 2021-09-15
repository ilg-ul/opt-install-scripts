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

HB_PREFIX=${HB_PREFIX:-"$HOME/opt/homebrew/qemu"}
export HOMEBREW_NO_EMOJI=1

export HOMEBREW_NO_AUTO_UPDATE=1

brew_git_url="https://github.com/Homebrew/brew.git"
brew_git_commit_id="2.2.0" # 2019-11-27

homebrew_core_git_url="https://github.com/Homebrew/homebrew-core.git"
homebrew_core_git_commit_id="cc307630acd25208a68941b148abaf03941b0a73" # 2019-12-06

if true
then

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

fi

PATH="${HB_PREFIX}/bin:${PATH}"
export PATH

hash -r 

# -----------------------------------------------------------------------------
  
echo
brew --version

cd "${HB_PREFIX}"

# -----------------------------------------------------------------------------

brew install qemu

# -----------------------------------------------------------------------------

# To use Homebrew, add something like this to ~/.profile
echo alias aqemu=\'export PATH=${HB_PREFIX}/bin:\${PATH}\'
