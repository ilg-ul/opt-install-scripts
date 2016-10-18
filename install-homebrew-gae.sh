#!/usr/bin/env bash

if [[ ${DEBUG} != "" ]]; then
  set -x 
fi

set -o errexit 
set -o pipefail 
set -o nounset 

IFS=$'\n\t'

# https://gist.github.com/ilg-ul/383869cbb01f61a51c4d
# ----------------------------------------------------------------------------

HB_PREFIX=${HB_PREFIX:-"$HOME/opt/homebrew-gae"}

echo "Recreating \"${HB_PREFIX}\"...
rm -rf "${HB_PREFIX}"
mkdir -p "${HB_PREFIX}"

PATH=${HB_PREFIX}/bin:$PATH

bash -c "(curl -L https://github.com/Homebrew/homebrew/tarball/master | tar -x -v --strip 1 -C "${HB_PREFIX}" -f -)"
brew --version

echo "Updating homebrew..."
rm -rf "${HB_PREFIX}/share/doc/homebrew"
brew update

# To use Homebrew, add something like this to ~/.profile
echo alias hbg=\'export PATH=${HB_PREFIX}/bin:\$PATH\'