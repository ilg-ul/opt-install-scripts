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
# This script installs a local instance of TeX Live (https://tug.org/texlive/).

tl_url=http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tl_archive_name="install-tl-unx.tar.gz"
tl_archive_path="$HOME/Downloads/${tl_archive_name}"
tl_folder="/tmp/install-tl"

# The install destination folder.
texlive_prefix="${HOME}/opt/texlive"

# -----------------------------------------------------------------------------

# Download the install tools.
if [ ! -f "${tl_archive_path}" ]
then
  curl -L "${tl_url}" -o "${tl_archive_path}"
fi

rm -rf "${tl_folder}"
mkdir -p "${tl_folder}"

# Unpack the install tools.
tar x -v -C "${tl_folder}" --strip-components 1 -f "${tl_archive_path}"

# -----------------------------------------------------------------------------

if [ -d "${texlive_prefix}" ]
then
  rm -rf "${texlive_prefix}.bak"
  # Backup previous install.
  mv "${texlive_prefix}" "${texlive_prefix}.bak"
fi

mkdir -p "${texlive_prefix}"

# -----------------------------------------------------------------------------

# Create the texlive.profile used to automate the install.
tmp_profile=$(mktemp)

# Note: __EOF__ is not quoted to allow local substitutions.
cat <<__EOF__ >> "${tmp_profile}"
# texlive.profile, copied from MacTex
TEXDIR ${texlive_prefix}
TEXMFCONFIG ${texlive_prefix}/texmf-config
TEXMFHOME ${texlive_prefix}/texmf
TEXMFLOCAL ${texlive_prefix}/texmf-local
TEXMFSYSCONFIG ${texlive_prefix}/texmf-config
TEXMFSYSVAR ${texlive_prefix}/texmf-var
TEXMFVAR ${texlive_prefix}/texmf-var
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
time caffeinate "${tl_archive_path}/install-tl" \
-no-gui -lang en \
-profile "${tmp_profile}" 

# -----------------------------------------------------------------------------

rm "${tmp_profile}"

echo
echo "Done."

# -----------------------------------------------------------------------------
