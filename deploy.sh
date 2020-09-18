#!/bin/bash
set -o errexit -o nounset
PKG_REPO=$PWD
#PKG_TARBALL=`Rscript -e "inteRgrate::get_pkg_tar_ball()"`
addToDrat(){
    Rscript -e "cli::cli_h2('Adding tar ball to drat')"

    Rscript -e "cli::cli_alert_info('Building .tar.gz')"
    Rscript -e "inteRgrate::build_pkg()"
    
    Rscript -e "cli::cli_alert_info('Committing .tar.gz to drat')"
    cd .. && cd drat
    Rscript -e "drat::insertPackage(Sys.getenv('PKG_TARBALL_PATH'), repodir = '.', \
                        commit = 'Travis update $PKG_REPO: build $TRAVIS_BUILD_NUMBER')"

    Rscript -e "cli::cli_alert_info('Pushing to drat')"
    git push 2>err.txt
    cd ..
    
    Rscript -e "cli::cli_alert_success('All done')"
}

addToDrat
