#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ ! -z ${DEBUG} ]]
then
  set ${DEBUG} # Activate the expand mode if DEBUG is -x.
else
  DEBUG=""
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.

# Remove the initial space and instead use '\n'.
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# This script installs a local instance of xc3sprog (http://xc3sprog.sourceforge.net).

xc3sprog_svn_url="http://xc3sprog.svn.sourceforge.net/svnroot/xc3sprog/trunk"
xc3sprog_build_folder_path="${HOME}/tmp/xc3sprog"
# The install destination folder.
xc3sprog_prefix="${HOME}/opt/xc3sprog"

hb_folder_path="${HOME}/opt/homebrew-xc3sprog"

# -----------------------------------------------------------------------------

mkdir -p "${xc3sprog_build_folder_path}"
cd "${xc3sprog_build_folder_path}"

if [ ! -d "xc3sprog.svn" ]
then
  echo
  echo "Checking out '${xc3sprog_svn_url}'..."
  svn co ${xc3sprog_svn_url} xc3sprog.svn
fi

(
  export PATH="${hb_folder_path}/bin":${PATH}

  PREFIX="${HOME}/opt/xc3sprog"
  rm -rf "${PREFIX}"

  rm -rf build
  mkdir -p build
  cd build
  echo
  echo "Running cmake..."

  cmake \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_CXX_FLAGS="-Wno-sometimes-uninitialized -Wno-self-assign -Wno-unused-private-field -Wno-format -Wno-unused-variable" \
  ../xc3sprog.svn

  echo
  echo "Running make..."
  make
  make install
);

# -----------------------------------------------------------------------------

echo
echo "Done."

# -----------------------------------------------------------------------------
