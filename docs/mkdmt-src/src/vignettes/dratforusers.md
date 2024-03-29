# Drat Basics for Package Users: Installing or Updating Packages

Dirk Eddelbuettel  
2015-05-24  

## Drat Overview

The [drat](https://dirk.eddelbuettel.com/code/drat.html) package makes it
trivially easy to deploy package repositories.  There are essentially just
two ways to use a package repository:

1) You _write_ to the repository as a _package author_ to publish your package; or
1) You _read_ from the reposiory as a _package user_ to install or update one or more packages.

This vignette deals with the second case: How to use
[drat](https://dirk.eddelbuettel.com/code/drat.html) as package users.  A
[companion vignette for package authors](/vignettes/dratforauthors) is available as well.


## Case 1: Using GitHub

[drat](https://dirk.eddelbuettel.com/code/drat.html) makes it _very_ easy to
use an R package repository hosted on GitHub.  It assumes simply that the R
package repository is hosted in a GitHub repository named `drat`.  With that,
we only need one piece of information: the name of the repository (and if
this seem mysterious see the discussion in the
[companion vignette](/vignettes/dratforauthors).  So

```
drat::addRepo("eddelbuettel")
```

adds my drat repo (which contains only the drat package in order to keep the
footprint of forking small).

One can add several repositories at once. The following statements adds the
repo for Rcpp and my catch-all ghrr repo:

```
drat::addRepo(c("eddelbuettel", "RcppCore", "ghrr"))
```

Note that this use a vectorised first argument, rather than three arguments.


## Case 2: Using Another Repo

Sometimes we want to use repositories not conforming to the GitHub `drat`
pattern.  This use case may simply be a different URL, or server.  Another
common (and very useful case) is for a locally hosted repository.

In this case we use the two argument form: the first argument sets the name
within the `repos` vector, and the second provides the local (filesystem-based)
or remote (web-based) URL:

```
drat::addRepo("workgroup", "file://nfs/groups/groupABC/R/drat")
```

where the same local network repository example is used as in the example in
the [companion vignette](/vignettes/dratforauthors).  Note that we start the
location URL with `file:`.


## Summary

[drat](https://dirk.eddelbuettel.com/code/drat.html) makes it very easy to
register additional package repositories. One or more calls to
`drat::addRepo()` is all that it takes as shown above. After that, one can
use `install.packages()` or `update.packages()` just as before, but with the
additional repositories at one's disposal.
