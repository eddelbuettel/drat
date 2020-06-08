#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD
#PKG_TARBALL=`Rscript -e "inteRgrate::get_pkg_tar_ball()"`
addToDrat(){
    Rscript -e "inteRgrate::build_pkg()"
    cd ..; cd drat
    Rscript -e "drat::insertPackage(Sys.getenv('PKG_TARBALL_PATH'), repodir = '.', \
                        commit='Travis update $PKG_REPO: build $TRAVIS_BUILD_NUMBER')"
  git push 2>err.txt
  cd ..
}


addToDrat
