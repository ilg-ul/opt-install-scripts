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

echo
echo "Checking if Xcode Command Line Tools are installed..."
xcode-select -p

# -----------------------------------------------------------------------------
# This script installs a local instance of TeX Live (https://tug.org/texlive/).

#tl_folder="/tmp/install-tl"

#tl_archive_name="install-tl-unx.tar.gz"
#tl_archive_path="$HOME/Downloads/${tl_archive_name}"
# tl_url=http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
#tl_repo_url=ftp://tug.org/historic/systems/texlive/2016/tlnet-final
#tl_archive_url=ftp://tug.org/historic/systems/texlive/2016/${tl_archive_name}

#tl_iso_mnt="/tmp/tl"

tl_iso_name="texlive.iso"
tl_iso_path="$HOME/Downloads/${tl_iso_name}"
tl_iso_url="ftp://tug.org/historic/systems/texlive/2016/texlive.iso"

# The install destination folder.
texlive_prefix="${HOME}/opt/texlive2"

tl_folder="/Volumes/TeXLive2016"

# -----------------------------------------------------------------------------

# Download the install tools.
if [ ! -f "${tl_iso_path}" ]
then
  echo
  echo "Downloading '${tl_iso_url}'..."
  curl --fail -L "${tl_iso_url}" -o "${tl_iso_path}"
fi

hdiutil mount "${tl_iso_path}" 

# -----------------------------------------------------------------------------

if [ -d "${texlive_prefix}" ]
then
  rm -rf "${texlive_prefix}.bak"
  echo "Backing-up previous install..."
  mv "${texlive_prefix}" "${texlive_prefix}.bak"
fi

mkdir -p "${texlive_prefix}"

# -----------------------------------------------------------------------------

# Create the texlive.profile used to automate the install.
# These definitions are specific to TeX Live 2016.
tmp_profile=$(mktemp)

# Note: __EOF__ is not quoted to allow local substitutions.
cat <<__EOF__ >> "${tmp_profile}"
# texlive.profile, copied from MacTex
TEXDIR ${texlive_prefix}
TEXMFCONFIG ~/.texlive/texmf-config
TEXMFHOME ~/texmf
TEXMFLOCAL ${texlive_prefix}/texmf-local
TEXMFSYSCONFIG ${texlive_prefix}/texmf-config
TEXMFSYSVAR ${texlive_prefix}/texmf-var
TEXMFVAR ~/.texlive/texmf-var
# binary_universal-darwin 1
binary_universal-darwin 0
binary_x86_64-darwin 1
collection-basic 1
collection-bibtexextra 1
collection-binextra 1
collection-context 1
collection-fontsextra 1
collection-fontsrecommended 1
collection-fontutils 1
collection-formatsextra 1
collection-games 1
collection-genericextra 1
collection-genericrecommended 1
collection-htmlxml 1
collection-humanities 1
collection-langafrican 1
collection-langarabic 1
collection-langchinese 1
collection-langcjk 1
collection-langcyrillic 1
collection-langczechslovak 1
collection-langenglish 1
collection-langeuropean 1
collection-langfrench 1
collection-langgerman 1
collection-langgreek 1
collection-langindic 1
collection-langitalian 1
collection-langjapanese 1
collection-langkorean 1
collection-langother 1
collection-langpolish 1
collection-langportuguese 1
collection-langspanish 1
collection-latex 1
collection-latexextra 1
collection-latexrecommended 1
collection-luatex 1
collection-mathextra 1
collection-metapost 1
collection-music 1
collection-omega 1
collection-pictures 1
collection-plainextra 1
collection-pstricks 1
collection-publishers 1
collection-science 1
collection-texworks 1
collection-xetex 1
in_place 0
option_adjustrepo 0
option_autobackup 1
option_backupdir tlpkg/backups
option_desktop_integration 1
option_doc 1
option_file_assocs 1
option_fmt 1
option_letter 1
option_menu_integration 1
option_path 0
option_post_code 1
option_src 1
option_sys_bin /usr/local/bin
option_sys_info /usr/local/share/info
option_sys_man /usr/local/share/man
option_w32_multi_user 1
option_write18_restricted 1
portable 0
__EOF__

# -----------------------------------------------------------------------------

# https://www.tug.org/texlive/doc/install-tl.html

# Prevent power saving mode.
echo
echo "Running install-tl..."
time "${tl_folder}/install-tl" \
-no-gui \
-lang en \
-profile "${tmp_profile}" 

# -----------------------------------------------------------------------------

# rm "${tmp_profile}"

umount "${tl_folder}"

echo
echo "Done."

# -----------------------------------------------------------------------------
