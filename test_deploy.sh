#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD
getRepo(){
  cd ..; mkdir drat; cd drat

  ## Set up Repo parameters
  git init
  git config user.name "Jumping Rivers"
  git config user.email "colin@jumpingrivers.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GITHUB_PAT@github.com/JR-packages/drat.git"
  git fetch --depth 1 upstream 2>err.txt
  Rscript -e "file.remove('err.txt')"
  git checkout gh-pages
}

testPush(){
  git push
  cd ..
}

if [[ $TRAVIS_PULL_REQUEST == “false” ]] && [[ $TRAVIS_BRANCH == “master” ]]
then
  getRepo
  testPush
else
  echo "Not master"
fi
