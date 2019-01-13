#!/usr/bin/env bash

SCRIPT_BASEDIR=$(dirname "$0")
SCRIPT_BASENAME=$(basename "$0")
formula="$1"
formula_file="${formula}.rb"


if [[ "$(uname -s)" != "Darwin" ]]; then
	echo 'WARNING: it is recommented to run this script under macOS. not tested under other operating systems.'
	exit 1
fi
if [[ -z "${formula}" ]] ; then
	echo "Usage: ${SCRIPT_BASENAME} <formula>"
	exit 3
fi

which jfrog &> /dev/null || { echo 'ERROR: jfrog not found in PATH'; exit 1; }
which jsonpp &> /dev/null || { echo 'ERROR: jsonpp not found in PATH'; exit 1; }

set -e
cd "${SCRIPT_BASEDIR}/.."
[[ -f .env ]] && source .env

# JFrog
JFROG_CLI_HOME_DIR="${PWD}/.jfrog"
export JFROG_CLI_HOME_DIR JFROG_CLI_OFFER_CONFIG
if [[ ! -d "${JFROG_CLI_HOME_DIR}" ]]; then
	echo "setup jfrog"
	jfrog bt c --user "${JFROG_USER}" --key "${JFROG_KEY}" --licenses "${JFROG_LICENSES}"
fi

cp ${formula_file} ${TAP_PATH}

mkdir -p tmp
pushd tmp > /dev/null

bottle_tmp_dir=$(mktemp -d ./${formula}_bottle.XXXXXXXXXXXXXXXXX)
pushd "${bottle_tmp_dir}" > /dev/null

brew remove ${formula} || true
brew install --verbose --build-bottle ${formula}
brew bottle --json ${formula}

bottle_json_file=$(ls -1 *.json | head -1)
if [[ -z "${bottle_json_file}" ]]; then
	echo "ERROR: empty json file"
	exit 1
fi
bottle_pjson_file=${bottle_json_file}.pretty

echo "json file: '${bottle_json_file}'"
echo "pjson file: '${bottle_pjson_file}'"

cat ${bottle_json_file} | jsonpp > ${bottle_pjson_file}

remote_filename=$(awk '/"filename/ { gsub(/[",]/, "", $2) ; print $2 }' ${bottle_pjson_file})
echo "remote_filename: '${remote_filename}'"

local_filename=$(awk '/local_filename/ { gsub(/[",]/, "", $2); print $2 }' ${bottle_pjson_file})
echo "local_filename: '${local_filename}'"

pkg_version=$(awk '/pkg_version/ { gsub(/[",]/, "", $2); print $2 }' ${bottle_pjson_file})

set -x
jfrog bt vc ${BINTRAY_REPOSITORY}/${formula}/v${pkg_version} || true
jfrog bt u --publish=true ./${local_filename} ${BINTRAY_REPOSITORY}/${formula}/v${pkg_version} ${remote_filename}
set +x

popd > /dev/null
pwd
rm -r ${bottle_tmp_dir}

pushd "${TAP_PATH}" > /dev/null
git checkout -- ${formula_file}
