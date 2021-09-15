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

HB_PREFIX=${HB_PREFIX:-"$HOME/opt/homebrew/gcc"}
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

# brew tap homebrew/versions

# -----------------------------------------------------------------------------

# brew install gcc@4.8
# brew install gcc@4.9

# GCC 5 no longer builds.
# brew install gcc@5
brew install gcc@6
brew install gcc@7

# Now available from core: llvm@3.8, llvm@3.9, but do not work as expected.
# brew instal llvm@3.8

# GDB 8.1 fails, use 8.0
# https://stackoverflow.com/questions/49001329/gdb-doesnt-work-on-macos-high-sierra-10-13-3

# brew install gdb
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/9ec9fb27a33698fc7636afce5c1c16787e9ce3f3/Formula/gdb.rb
brew pin gdb

# https://sourceware.org/gdb/wiki/BuildingOnDarwin
echo "codesign -s gdb-cert $(which gdb)"
echo "cat set startup-with-shell off >>.gdbinit"

# -----------------------------------------------------------------------------

# To use Homebrew, add something like this to ~/.profile
echo alias agcc=\'export PATH=${HB_PREFIX}/bin:\${PATH}\'
