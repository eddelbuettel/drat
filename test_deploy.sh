#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD
getRepo(){
  cd ..; mkdir drat; cd drat

  if [ -z "$GITHUB_PAT"]
  then
	  echo "GITHUB_PAT empty"
	  exit 1
  fi


  ## Set up Repo parameters
  git init
  git config user.name "Jumping Rivers"
  git config user.email "colin@jumpingrivers.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GITHUB_PAT@github.com/JR-packages/drat.git"
  git fetch upstream 2>err.txt
  Rscript -e "file.remove('err.txt')"
  git checkout gh-pages
}

addToDrat(){
  Rscript -e "drat::insertPackage('$PKG_REPO/$PKG_TARBALL', \
    repodir = '.', \
    commit='Travis update $PKG_REPO: build $TRAVIS_BUILD_NUMBER')"
  git push 2>err.txt || travis terminate 1
  cd ..
}


getRepo
addToDrat
