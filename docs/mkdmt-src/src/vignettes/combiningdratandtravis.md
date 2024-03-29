# Combining Drat and Travis CI

Colin Gillespie and Dirk Eddelbuettel  
2015-04-14  


## What is Travis CI?

[Travis CI](https://travis-ci.com/) is a hosted continuous integration service. 
It is integrated with GitHub and offers first class support for a number of languages, 
but importantly for us, R. 
Travis CI enables package authors to continually ensure their package always build and
passes associated unit tests. 

Whenever a commit is pushed to a git repository that contains an R package, 
Travis CI attempts to build the associated R package (see 
[r-travis](https://github.com/craigcitro/r-travis) for R specific examples).
This ensures the repository 
always contains a working package. This vignette describes a modification to the standard
Travis CI workflow. If a package build is successful, the package is then
pushed to a [drat](http://dirk.eddelbuettel.com/code/drat.html) repository.


## Preliminaries

Unsurprisingly in order to integrate Travis CI with drat, you must first to have a 
[drat](https://github.com/eddelbuettel/drat) repository and secondly add 
[Travis CI](https://github.com/craigcitro/r-travis) support to that repository.


## Workflow

1. To allow Travis CI to push to your GitHub repository, we need to 
generate a GitHub [API token](https://github.com/settings/tokens/new).
After re-entering your password, just select `repo`, or
if your repository is public, select `public_repo`. GitHub will create the token 
and give you a chance to copy it down.

1. Travis CI will then [encrypt](http://docs.travis-ci.com/user/encryption-keys/) this token. 
The short story is:
```
# Install Ruby first. This may require sudo
gem install travis
```
If `sudo` is not available, you can do a local install
```
# Look at ~/.gem/
gem install --user-install travis
```
1. `cd` to the R package directory and run
```
travis encrypt GH_TOKEN=$MY_ACCESS_TOKEN --add env.global
```
where `$MY_ACCESS_TOKEN` is your access token. The `--add env.global` automatically adds the token to your `.travis.yml` file.
1. Add the `deploy.sh` shell script to your repository and edit appropriately. An example
is found at the end of this vignette and also in the 
[dratTravis](https://github.com/csgillespie/dratTravis) repository.

1. Add the lines
```
    after_success:
      - test $TRAVIS_PULL_REQUEST == "false" && 
        test $TRAVIS_BRANCH == "master" && 
        bash deploy.sh
```
    to your `.travis.yml` file. This means your `drat` repository is only updated
      - for successful builds;
      - only on the master branch;
      - and not for pull requests.
      
      
      
## Example `deploy.sh` script

```
#!/bin/bash
set -o errexit -o nounset
addToDrat(){
  PKG_REPO=$PWD

  cd ..; mkdir drat; cd drat

  ## Set up Repo parameters
  git init
  git config user.name "XXX YYY"
  git config user.email "XXXX@example.com"
  git config --global push.default simple

  ## Get drat repo
  git remote add upstream "https://$GH_TOKEN@github.com/GITHUB_USERNAME/drat.git"
  git fetch upstream 2>err.txt
  git checkout gh-pages

  Rscript -e "drat::insertPackage('$PKG_REPO/$PKG_TARBALL', \
    repodir = '.', \
    commit='Travis update: build $TRAVIS_BUILD_NUMBER')"
  git push 2> /tmp/err.txt

}
addToDrat
```

If you use a `docs/` directory in the main branch, omit `git checkout
gh-pages` and use `cd docs` instead.
