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

# https://maven.apache.org/download.cgi?Preferred=http%3A%2F%2Fmirror.evowise.com%2Fapache%2F#
# http://mirrors.nav.ro/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

mvn_version="3.8.2"
mvn_major="$(echo ${mvn_version} | sed -e 's/\([0-9]*\)\..*/\1/')"
mvn_folder="apache-maven-${mvn_version}"
mvn_archive="${mvn_folder}-bin.tar.gz"
mvn_url="http://mirrors.nav.ro/apache/maven/maven-${mvn_major}/${mvn_version}/binaries/${mvn_archive}"
mvn_download="/tmp/maven"
mvn_install="${HOME}/.local"

mkdir -p "${mvn_download}"
if [ ! -f "${mvn_download}/${mvn_archive}" ]
then
  curl -L "${mvn_url}" -o "${mvn_download}/${mvn_archive}"
fi

rm -rf "${mvn_install}/${mvn_folder}"
tar -x -z -f "${mvn_download}/${mvn_archive}" -C "${mvn_install}" 

echo
echo "Done."

echo alias amaven=\'export PATH=${HOME}/.local/${mvn_folder}/bin:\${PATH}\'
