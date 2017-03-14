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

HB_PREFIX=${HB_PREFIX:-"$HOME/opt/homebrew-newt"}
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

brew tap homebrew/versions

# -----------------------------------------------------------------------------

brew install gcc5 gdb
brew install go
brew install tree

# -----------------------------------------------------------------------------

# To use Homebrew, add something like this to ~/.profile
echo alias anewt=\'export PATH=${HB_PREFIX}/bin:\${PATH}\; export GOPATH=\$HOME/dev/go\\'

