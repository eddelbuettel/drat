
## In No Particular Order Yet

- Pushing directly to GitHub would be nice to have eventually if we can get
  hold of a package without too many extra depends. Possible requirements:
  + switching to gh-pages (and back)
  + commit
  + push
  [ Partially DONE -- might be useful to look into the git2r package ]
  [ Added on Jan 28 via simple system() call; needs more robust interface ]
  [ DONE via git2r ]

- Supporting binary packages (for Windows and maybe OS X) would nice but is
  lower priority -- especially as R now tries binary _and_ source
  [ DONE thanks to Jan ]

- Signing the PACKAGES file via gpg (a la Debian) would be a nice
  step. Validation would be needed as well.

- Supports GH orgs? That is just an account name after all.
  [ DONE, see the RcppCore drat repo ]

- Mention http://stackoverflow.com/questions/2905650/creating-a-local-r-package-repository/

- [DONE] Should add() be called subscribe(), and insert() be called insertRelease()
  or addRelease() ?

- Generalize regular expression from ".tar.gz" to tarballs compressed with
  other compression algorithms just like `tools/packages.R` does
  [ DONE in pruneRepo.R ]
