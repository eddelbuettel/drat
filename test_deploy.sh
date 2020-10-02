#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD
getRepo(){
  cd ..; mkdir drat; cd drat

  ## Set up Repo parameters
  git init
  git config user.name "Travis Drat Bot"
  git config user.email "travis@drat.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GITHUB_PAT@github.com/JR-packages/drat.git"
  git fetch --depth 1 upstream gh-pages 2>err.txt
  rm -fv err.txt
  git checkout gh-pages
}

testPush(){
  git push
  cd ..
}

getRepo
testPush

