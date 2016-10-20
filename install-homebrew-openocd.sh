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

echo "Recreating \"${HB_PREFIX}\"..."
rm -rf "${HB_PREFIX}"
mkdir -p "${HB_PREFIX}"

PATH=${HB_PREFIX}/bin:$PATH

bash -c "(curl -L https://github.com/Homebrew/homebrew/tarball/master | tar -x -v --strip 1 -C "${HB_PREFIX}" -f -)"
brew --version

echo "Updating homebrew..."
rm -rf "${HB_PREFIX}/share/doc/homebrew"
brew update

brew install automake
brew install cmake
brew install pkgconfig

# Required by QEMU
brew install gettext

# TeX required to build openOCD & QEMU manuals.
brew install Caskroom/cask/mactex

# /Library/TeX/texbin
echo 'rm /etc/paths.d/TeX'
sudo rm -f /etc/paths.d/TeX 

if false
then
# X11 headers required by QEMU (in SDL).
brew install Caskroom/cask/xquartz

# /opt/X11/bin
echo '/etc/paths.d/40-XQuartz'
sudo rm -f /etc/paths.d/40-XQuartz
fi

# makeinfo required to build openOCD & QEMU manuals.
brew install texinfo

# To use Homebrew, add something like this to ~/.profile
echo alias hbg=\'export PATH=${HB_PREFIX}/bin:\$PATH\'
