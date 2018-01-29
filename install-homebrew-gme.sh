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
xcode-select -print-path

# -----------------------------------------------------------------------------

HB_PREFIX=${HB_PREFIX:-"$HOME/opt/homebrew/gme"}
export HOMEBREW_NO_EMOJI=1

echo "Recreating \"${HB_PREFIX}\"..."
rm -rf "${HB_PREFIX}"
mkdir -p "${HB_PREFIX}"

PATH=${HB_PREFIX}/bin:${PATH}

# -----------------------------------------------------------------------------

bash -c "(curl -L https://github.com/Homebrew/homebrew/tarball/master | \
  tar -x -v --strip 1 -C "${HB_PREFIX}" -f -)"
  
brew --version

echo "Updating homebrew..."
rm -rf "${HB_PREFIX}/share/doc/homebrew"
brew update

# -----------------------------------------------------------------------------

brew install automake
brew install cmake
brew install pkgconfig

# Required by QEMU
brew install gettext
brew link gettext --force

# makeinfo required to build openOCD & QEMU manuals.
brew install texinfo
brew link texinfo --force

# libtool required to build openOCD (bootstrap) 
brew install libtool

# gawk & gsed required by GCC
brew install gawk gnu-sed

# -----------------------------------------------------------------------------

cat <<'__EOF__' > "${HB_PREFIX}"/bin/pkg-config-verbose
#! /bin/sh
# pkg-config wrapper for debug

pkg-config $@
RET=$?
OUT=$(pkg-config $@)
echo "($PKG_CONFIG_PATH) | pkg-config $@ -> $RET [$OUT]" >&2
exit ${RET}

__EOF__

chmod +x "${HB_PREFIX}"/bin/pkg-config-verbose

# -----------------------------------------------------------------------------

# To use Homebrew, add something like this to ~/.profile
echo alias agme=\'export PATH=${HB_PREFIX}/bin:\${PATH}\'
