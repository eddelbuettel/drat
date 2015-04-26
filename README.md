## drat [![Build Status](https://travis-ci.org/eddelbuettel/drat.png)](https://travis-ci.org/eddelbuettel/drat) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html) [![Downloads](http://cranlogs.r-pkg.org/badges/drat?color=brightgreen)](https://github.com/metacran/cranlogs.app)

Drat R Archive Template

### Background

The R package ecosystem is one of the cornerstones of the success seen by R.
As of this writing, over 6500 packages are on [CRAN](http://cran.r-project.org),
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

### Installation

You can install the package from [CRAN](http://cran.r-project.org) via the
standard `install.packages("drat")`.  Alternatively,  you can also do

```{.r}
install.packages("drat", repos="http://eddelbuettel.github.io/drat")
``` 

to install directly from the drat repository. 

### Getting Started

See the vignettes 

- [Drat for Package Authors](http://eddelbuettel.github.io/drat/DratForPackageAuthors.html), 
- [Drat for Package Users](http://eddelbuettel.github.io/drat/DratForPackageUsers.html)

for the two principal uses cases.  Also see
[Why Drat?](http://eddelbuettel.github.io/drat/WhyDrat.html) for basic
motivation.  The package documentation provides more details.  The
[drat package page](http://dirk.eddelbuettel.com/code/drat.html) has a longer
tutorial, and the
[blog section on drat](http://dirk.eddelbuettel.com/blog/code/drat/) has even
more.

### Status

The package is available from [CRAN](http://cran.r-project.org) and starting
to get some use. Possible improvements, additions and next steps are listed
in the
[TODO.md](https://github.com/eddelbuettel/drat/blob/master/inst/TODO.md)
file.

A few drat repositories are starting to appear (besides this one). An incomplete list (looking at the direct forks as well as GitHub search):

 - [hrbrmstr](https://github.com/hrbrmstr/drat)
 - [yutannihilation](https://github.com/yutannihilation/drat)
 - [gschofl](https://github.com/gschofl/drat/)
 - [csgillespie](https://github.com/csgillespie/drat)
 - [homerhanumat](https://github.com/homerhanumat/drat)
 - [cboettig](https://github.com/cboettig/drat)
 - [shabbychef](https://github.com/shabbychef/drat)
 - [RcppCore](https://github.com/RcppCore/drat)
 - [arilamstein](https://github.com/arilamstein/drat)
 - [piccolbo](https://github.com/piccolbo/drat)
 - [ghrr](https://github.com/ghrr/drat)

### Travis Integration

Colin Gillespie has started to integrate
[Travis CI](http://www.travis-ci.org) with dart, see his
[dratTravis](https://github.com/csgillespie/dratTravis) repository for more
details, and the contributed vignette
[Combining Drat and Travis](http://eddelbuettel.github.io/drat/DratForPackageAuthors.htm)

### Author

Dirk Eddelbuettel 

### License

GPL (>= 2)

