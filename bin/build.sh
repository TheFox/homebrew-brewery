#!/usr/bin/env bash

# 1. Downloads gzip from GitHub release (Git Tag).
# 2. Take template from 'skel/' by formula name and
#    commit it to root directory.

SCRIPT_BASEDIR=$(dirname "$0")
SCRIPT_BASENAME=$(basename "$0")
GITHUB_BASE_URL=${GITHUB_BASE_URL:-https://github.com/TheFox}
formula="$1"
version="$2"
GITHUB_REPO_URL=${GITHUB_REPO_URL:-https://github.com/TheFox/${formula}}


if [[ "$(uname -s)" != "Darwin" ]]; then
	echo 'WARNING: it is recommented to run this script under macOS. not tested under other operating systems.'
	exit 1
fi
if [[ -z "${formula}" ]] || [[ -z "${version}" ]]; then
	echo "Usage: ${SCRIPT_BASENAME} <formula> <version>"
	echo
	echo "version without 'v' at the beginning."
	exit 3
fi
which sha2 &> /dev/null || { echo 'ERROR: sha2 not found in PATH'; exit 1; }
which curl &> /dev/null || { echo 'ERROR: curl not found in PATH'; exit 1; }
which wget &> /dev/null || { echo 'ERROR: wget not found in PATH'; exit 1; }
which stat &> /dev/null || { echo 'ERROR: stat not found in PATH'; exit 1; }

set -e
cd "${SCRIPT_BASEDIR}/.."
mkdir -p tmp

# Create variables.
vversion="v${version}"
formula_file_path="${formula}.rb"
formula_skel_file_path="skel/${formula_file_path}"
remote_gz_file_name="${vversion}.tar.gz"
local_gz_file_name="${formula}_${remote_gz_file_name}"
tmp_gz_file_path="tmp/${local_gz_file_name}"
url="${GITHUB_REPO_URL}/archive/${remote_gz_file_name}"

if [[ ! -f "${tmp_gz_file_path}" ]]; then
	# Download release file from GitHub.
	echo "download gz file '${url}'"
	if ! wget --quiet -O "${tmp_gz_file_path}" "${url}"; then
		echo 'ERROR: wget failed'
		if ! curl -s -S -L --ssl -o "${tmp_gz_file_path}" "${url}" ; then
			exit 1
		fi
	fi
fi

# Make SHA256 hex for downloaded file.
echo "create sha256 for '${tmp_gz_file_path}'"
sha256hex=$(sha2 -256 -q "${tmp_gz_file_path}" | awk '{ print $1 }')
echo "sha256 hex '${sha256hex}'"

# Print file type.
echo 'file type:'
file "${tmp_gz_file_path}"
if ! file "${tmp_gz_file_path}" | grep --silent 'gzip compressed data'; then
	echo 'ERROR: file is wrong type'
	exit 1
fi

# Create formula file from template (in skel/).
echo "create ${formula_file_path}"
sed -e "
s|%VERSION%|${vversion}|g;
s|%VERSION_SHORT%|${version}|g;
s|%SHA256%|${sha256hex}|g;
/File type:/ s|skel|production|g;
" "${formula_skel_file_path}" > "${formula_file_path}"
