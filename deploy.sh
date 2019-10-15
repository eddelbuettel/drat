#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD
#PKG_TARBALL=`Rscript -e "inteRgrate::get_pkg_tar_ball()"`
addToDrat(){
  cd ..; cd drat
  Rscript -e "drat::insertPackage('$PKG_REPO/$PKG_TARBALL', \
    repodir = '.', \
    commit='Travis update $PKG_REPO: build $TRAVIS_BUILD_NUMBER')"
  git push 2>err.txt
  cd ..
}


addToDrat
