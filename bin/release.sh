#!/usr/bin/env bash

SCRIPT_BASEDIR=$(dirname "$0")
formula="$1"
version="$2"


cd "${SCRIPT_BASEDIR}/.."

./bin/build.sh "${formula}" "${version}" || exit $?

echo 'add to git'
git add "${formula_file_path}"

echo 'git commit'
git commit -S -m "${formula} ${version}"
