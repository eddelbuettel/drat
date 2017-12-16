## drat [![Build Status](https://travis-ci.org/eddelbuettel/drat.svg)](https://travis-ci.org/eddelbuettel/drat) [![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html) [![CRAN](http://www.r-pkg.org/badges/version/drat)](https://cran.r-project.org/package=drat) [![Downloads](http://cranlogs.r-pkg.org/badges/drat?color=brightgreen)](http://www.r-pkg.org/pkg/drat)

Drat R Archive Template

### Background

The R package ecosystem is one of the cornerstones of the success seen by R.
As of September 2017, over 11000 packages are on [CRAN](https://cran.r-project.org),
with about one thousand more at [BioConductor](http://www.bioconductor.org) and
probably another hundred at [OmegaHat](http://www.omegahat.net).

Support for multiple repositories is built deeply into R; mostly via the
(default) package `utils`. The
[`update.packages`](http://www.rdocumentation.org/packages/utils/functions/update.packages)
function (along with several others from the `utils` package) can be used with
ease for these three default repositories as well as many others. But it
seemed that support for _simple creation and use_ of local repositories was
missing.

[Drat](http://dirk.eddelbuettel.com/code/drat.html) tries to help here and supports two principal modes:

- *GitHub* by leveraging `gh-pages`
- *Other repos* by using other storage where you can write and provide html access

Please see the next section about how to get started, the package documentation, the
[drat package page](http://dirk.eddelbuettel.com/code/drat.html) or the
[blog section on drat](http://dirk.eddelbuettel.com/blog/code/drat/) for more.

### Getting Started

See the vignettes 

- [Drat FAQ](http://eddelbuettel.github.io/drat/DratFAQ.html), 
- [Drat for Package Authors](http://eddelbuettel.github.io/drat/DratForPackageAuthors.html), 
- [Drat for Package Users](http://eddelbuettel.github.io/drat/DratForPackageUsers.html)
- [Why Drat?](http://eddelbuettel.github.io/drat/WhyDrat.html)
- [Drat Lightning Talk at useR!2015](http://dirk.eddelbuettel.com/papers/useR2015_drat.pdf)

for the FAQ, two principal uses cases, basic motivation and an overview / introduction.
The package documentation provides more details.  The
[drat package page](http://dirk.eddelbuettel.com/code/drat.html) has a longer
tutorial, and the
[blog section on drat](http://dirk.eddelbuettel.com/blog/code/drat/) has even
more.

### Installation

You can install the package from [CRAN](https://cran.r-project.org) via the
standard

```{.r}
install.packages("drat")
```

or alternatively,  you can also do

```{.r}
install.packages("drat", repos="http://eddelbuettel.github.io/drat")
``` 

to install directly from the drat repository. 


### Status

The package has been available from [CRAN](https://cran.r-project.org) since
the Spring of 2015 and starting to get some use. Possible improvements,
additions and next steps are listed in the
[TODO.md](https://github.com/eddelbuettel/drat/blob/master/inst/TODO.md)
file.

A few drat repositories are starting to appear (besides this one). An incomplete list (looking at the direct forks as well as GitHub search):

 - [yutannihilation](https://github.com/yutannihilation/drat)
 - [gschofl](https://github.com/gschofl/drat/)
 - [csgillespie](https://github.com/csgillespie/drat)
 - [shabbychef](https://github.com/shabbychef/drat)
 - [RcppCore](https://github.com/RcppCore/drat)
 - [arilamstein](https://github.com/arilamstein/drat)
 - [piccolbo](https://github.com/piccolbo/drat)
 - [ghrr](https://github.com/ghrr/drat)
 - [cloudyr](https://cloudyr.github.io/drat)
 - [dmlc](https://github.com/dmlc/drat)

The [rOpenSci](https://ropensci.org) project uses
[drat](http://dirk.eddelbuettel.com/code/drat.html) to distribute their code
and has written a
[nice blog post](https://ropensci.org/blog/2015/08/04/a-drat-repository-for-ropensci/)
about it.

### Travis Integration

Colin Gillespie has started to integrate
[Travis CI](http://www.travis-ci.org) with drat, see his
[dratTravis](https://github.com/csgillespie/dratTravis) repository for more
details, and the contributed vignette
[Combining Drat and Travis](http://eddelbuettel.github.io/drat/CombiningDratAndTravis.html)

### Author

Dirk Eddelbuettel, with contributions by Carl Boettiger, Sebastian Gibb,
Colin Gillespie, Matt Jones, Thomas Leeper, Steven Pav and Jan Schulz.

### License

GPL (>= 2)

