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

HB_PREFIX=${HB_PREFIX:-"$HOME/.local/homebrew/jekyll"}
export HOMEBREW_NO_EMOJI=1

export HOMEBREW_NO_AUTO_UPDATE=1

brew_git_url="https://github.com/Homebrew/brew.git"
brew_git_commit_id="3.2.11"

homebrew_core_git_url="https://github.com/Homebrew/homebrew-core.git"
homebrew_core_git_commit_id="1ce3271cff8ae34b6c297c11931e92a47b9130d7"

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

brew install ruby
# Required, otherwise the system gems are used
brew link --force ruby

hash -r 

which ruby
ruby --version
# 3.0.2p107

which gem
gem --version
# 3.2.22

which bundle
bundle --version
# 2.2.22

# jekyll is installed by the bundle install in each web source folder.

# -----------------------------------------------------------------------------

# To use Homebrew, add something like this to ~/.zprofile
echo alias ajkl=\'export PATH=${HB_PREFIX}/bin:\${PATH}\'
