#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD

addToDrat(){
  cd ..; mkdir drat; cd drat

  ## Set up Repo parameters
  git init
  git config user.name "Jumping Rivers"
  git config user.email "colin@jumpingrivers.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GITHUB_PAT@github.com/JR-packages/drat.git"
  git fetch upstream 2>err.txt
  git checkout gh-pages 

  Rscript -e "drat::insertPackage('$PKG_REPO/$PKG_TARBALL', \
    repodir = '.', \
    commit='Travis update $PKG_REPO: build $TRAVIS_BUILD_NUMBER')"
  git push 2>err.txt
  cd ..
}

addToWebSite(){
  R CMD INSTALL $PKG_REPO/$PKG_TARBALL
  Rscript -e "devtools::build_vignettes('$PKG_REPO')"
  mkdir rcourses_github_io; cd rcourses_github_io

  ## Set up Repo parameters
  git init
  git config user.name "Colin Gillespie"
  git config user.email "csgillespie@gmail.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GH_TOKEN@github.com/rcourses/rcourses.github.io.git"
  git fetch upstream 2>err.txt
  git checkout master
  git status
  
  cp -v $PKG_REPO/inst/doc/*.pdf $(basename $PKG_REPO)/
  git add $(basename $PKG_REPO)/*.pdf
  git commit -a -m "Travis update $PKG_REPO: build $TRAVIS_BUILD_NUMBER"

  git push 2>err.txt
  cd ..
}

addToDrat
#addToWebSite
