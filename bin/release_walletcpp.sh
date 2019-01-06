#!/usr/bin/env bash

SCRIPT_BASEDIR=$(dirname "$0")

cd "${SCRIPT_BASEDIR}/.."

./bin/release.sh wallet-cpp $@

export GITHUB_REPO_URL=https://github.com/TheFox/wallet-cpp
./bin/release.sh wallet-cpp-debug $@
