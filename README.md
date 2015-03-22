## drat [![Build Status](https://travis-ci.org/eddelbuettel/drat.png)](https://travis-ci.org/eddelbuettel/drat) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)

Drat R Archive Template

### Background

The R package ecosystem is one of the cornerstones of the success seen by R.
As of this writing, over 6200 packages are on [CRAN](http://cran.r-project.org),
several hundred more at [BioConductor](http://www.bioconductor.org) and at
[OmegaHat](http://www.omegahat.org).

Support for multiple repositories is built deeply into R; mostly via the
(default) package `utils`. The
[`update.packages`](http://www.rdocumentation.org/packages/utils/functions/update.packages)
function (along with several others from the `utils` package) can used with
ease for these three default repositories as well as many others. But it
seemed that support for _simple creation and use_ of local repositories was
missing.

Drat tries to help here and supports two principal modes:
- *GitHub* by leveraging `gh-pages`
- *Other repos* by using other storage where you can write and provide html access

See the next section about to get started, the package documentation, the
[drat package page](http://dirk.eddelbuettel.com/code/drat.html) or the
[blog section on drat](http://dirk.eddelbuettel.com/blog/code/drat/) for more.

### Getting Started

#### Installing drat

You can install the package from [CRAN](http://cran.r-project.org) via the
standard `install.packages("drat")`. See below for a way to install drat 
from its own drat repository.

#### Adding packages to a new drat repository

The following assumes that you want to add a drat repository to your github pages. 
The [right branch](https://help.github.com/articles/user-organization-and-project-pages/)
of the github pages is checked out at `/src/repo` and the pages are 
available on the web at <github_username>.github.io.

As a first step, add a `drat` subdirectory (`/src/repo/drat`). This is where 
new packages should be added to.

Package insertion into a repository then works by passing the package tarball
filename as an argument to `insertPackage()` or its shorthand variant:

```{.r}
drat:::insert("drat_0.0.1.tar.gz", repodir="/src/repo/drat")
```

Please note, that you can specify a default repository via 
`options(dratRepo="/src/repo/drat")` and then only pass in the filename of 
the package.

Now you can now `git add`, `commit` and `push` the new version of your github 
pages.

Please note, that there is currently only support for source packages, not Windows
Mac OSX binary packages.

#### Using your new drat repository

There are two ways to install packages from this new drat package repository:

Directly by specifying the `repos` argument to `install.packages()`:

```{.r}
install.packages("<package>", repos="http://<github_username>.github.io/drat", type="source")
```

Or add the this drat repository to the active package repositories 
(see `getOption("repos")`) and then install like usual: 

```{.r}
# adds your github pages as a new repository *during* this R session
drat:::add("<github-username>") 
# installs a package from that repository
install.packages("<package_in_your_drat_repo>", type="source") 
```

Please note, that `drat:::add("<github-username>")` assumes that your your 
drat repository is at ´http://<github_username>.github.io/drat`; you can specify 
other locations via a optional `alturl` parameter 
`addRepo("LocalRepo", alturl="file:///nas/R/repo")`.

If you add such a line to your session or startup files (see `help(Startup)`) you 
can permanently add this drat repository to your active package repositories
and use `update.packages()` as usual to update packages from there. If you don't 
do this, you have to remember to call `drat:::add("<github-username>")` before 
you try to update packages from this drat repository!

The package documentation provides more details; the
[drat package page](http://dirk.eddelbuettel.com/code/drat.html) has a longer
tutorial, and the
[blog section on drat](http://dirk.eddelbuettel.com/blog/code/drat/) has even
more.

### Experimental git features

A somewhat experimental `commit=TRUE` option exists for the `insertPackage()` 
aka `drat:::insert()` function, which checks out the `gh_pages` branch, adds 
the new and changed files, commits them and tries to push them. As this 
currently checks out the 'gh_pages' branch, this only works with normal project
repositories, but not with personal or organisational github pages 
([where the github pages are in the "master" branch](https://help.github.com/articles/user-organization-and-project-pages/)).

### Installing drat from source

drat is self hosting: you can use a drat repository to install and 
update drat itself:

As an alternatively for a first installation, you can use

```{.r}
install.packages("drat", repos="http://eddelbuettel.github.io/drat", type="source")
``` 

to install directly from the drat repository. 

To add this drat repository to your active package repositories, use 

```{.r}
drat:::add("eddelbuettel")
```

either temporary for the timespan of your current R session or permanently via
a line in your session or startup files (see `help(Startup)`).

To update drat from this repository, make sure that the drat repository is active 
and then simple call `update.packages()` as usual. 

### Status

The package is now available from [CRAN](http://cran.r-project.org). A few
possible improvements, additions and next steps are listed in the
[TODO.md](https://github.com/eddelbuettel/drat/blob/master/inst/TODO.md)
file.

A few drat repositories are starting to appear (besides this one). Via a
combination of looking at the direct forks as well as GitHub search, I became
aware of these:

 - [hrbrmstr](https://github.com/hrbrmstr/drat)
 - [yutannihilation](https://github.com/yutannihilation/drat)
 - [gschofl](https://github.com/gschofl/drat/)
 - [csgillespie](https://github.com/csgillespie/drat)
 - [homerhanumat](https://github.com/homerhanumat/drat)
 - [cboettig](https://github.com/cboettig/drat)
 - [shabbychef](https://github.com/shabbychef/drat)
 - [RcppCore](https://github.com/RcppCore/drat)
 - [arilamstein](https://github.com/arilamstein/drat)

### Author

Dirk Eddelbuettel 

### License

GPL (>= 2)

