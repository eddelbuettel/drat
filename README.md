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

You can install the package from [CRAN](http://cran.r-project.org) via the
standard `install.packages("drat")`.  Alternatively, for a first
installation, you can also do

```{.r}
install.packages("drat", repos="http://eddelbuettel.github.io/drat")
``` 

to install directly from the drat repository.  After either initial
installation, you can add line such as

```{.r}
drat:::add("eddelbuettel")
```

to your session or startup files (see `help(Startup)`) and use
`update.packages()` as usual---also reflection the new drat archive.

Package insertion into a repo then works by passing the package tarball
filename as an argument to `insertPackage()` or its shorthand variant:

```{.r}
drat:::insert("drat_0.0.1.tar.gz")
```

You can now add, commit and push the new version. A somewhat experimental
option also exists for the `insertPackage()` aka `drat:::insert()` function.

The package documentation provides more details; the
[drat package page](http://dirk.eddelbuettel.com/code/drat.html) has a longer
tutorial, and the
[blog section on drat](http://dirk.eddelbuettel.com/blog/code/drat/) has even
more.

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

