#!/bin/bash -xe

the_ref=fl4re-dev

set +x
echo "https://$GH_SB_USER:$GH_SB_PASS@github.com" > gh.credentials
set -x

git config --global credential.helper "store --file=\"$WORKSPACE/gh.credentials\""

pushd .
cd boost

# verify this is a git repo and exit with error if not
git rev-parse --is-inside-work-tree

# fetch & checkout
set +x
echo "Checking out and fetch"
set -x

# git fetch
git -c core.askpass=true fetch --tags --progress https://github.com/fl4re/boost.git $the_ref

git reset --hard && git clean -ffdx
git submodule foreach --recursive "git reset --hard && git clean -ffdx && git checkout -- ."

# git checkout
git checkout $the_ref

# submodules
git submodule sync --recursive
git submodule update --init --recursive

popd

git config --global --remove-section credential

rm gh.credentials

