#!/bin/sh

REPO_URL="https://steveww.org"

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
echo "creating repo"
mkdir repo
mv *.tgz repo
helm repo index repo --url=$REPO_URL
echo "Adding annotation"
yq e -i '.entries.observability.[].annotations."weave.works/profile" = "observability"' repo/index.yaml

ls -l repo
