#!/bin/sh

REPO_URL="https://steveww.github.io/profiles"

set -e

if [ -e repo ]
then
    echo "Cleaning up"
    rm -r repo
fi

echo "Updating dependencies"
helm dependency update observability
echo "Packaging"
helm package observability
helm package podinfo
echo "creating repo"
mkdir repo
mv *.tgz repo
helm repo index repo --url=$REPO_URL
# TODO - add, commit and push to gh-pages branch

ls -l repo
