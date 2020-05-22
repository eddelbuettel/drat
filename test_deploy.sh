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

addRSPM() {
    echo "options(repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/bionic/latest'),
     HTTPUserAgent = sprintf('R/%s R (%s)', getRversion(),               
                               paste(getRversion(), R.version['platform'],
                                      R.version['arch'], R.version['os'])),
     download.file.extra = sprintf('--header \"User-Agent: R (%s)\"',    
                                 paste(getRversion(), R.version['platform'], 
                                       R.version['arch'], R.version['os'])))" >> /usr/lib/R/etc/Rprofile.site
}

addRSPM
getRepo
testPush
