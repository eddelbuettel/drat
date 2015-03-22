#!/bin/bash

# be defensive
set -e
set -u

# helper functions
function die {
    echo "$@"
    exit -1
}

# check for mandatory argument
if [ $# -ne 1 ]; then die "Usage: git2targz.sh repourl"; fi
repo=$1

# assume a Unix-ish environment
if ! test -d /tmp; then die "No /tmp directory seen. Requiring Unix-alike system. Quitting."; fi

# assume git binary is somewhere
set +e
gitbinary=$(type -P git)
if [ "$?" = "1" ]; then
    die "No git binary found. Quitting." 
fi
set -e

tempdir=$(mktemp -d dratXXXXXX -p /tmp)
echo "Using temporary directory ${tempdir}"
echo
cd ${tempdir}

project=$(basename ${repo} .git)

git clone ${repo} ${project}
echo
echo "Building package from ${project}"
echo 
R CMD build ${project}

sha=$(cd ${project} && git log --format=fuller | head -6 | awk '/^commit / {print substr($2,1,7)}')

rm -rf ${project}/

tarball=$(ls -1 ${project}_*.tar.gz)

mv -v ${tarball} /tmp 
echo "${sha} -- ${repo}" > /tmp/${tarball}.meta.txt

rm -rf ${tempdir}
echo
echo "Created ${tarball} from commit ${sha} at ${repo}"
