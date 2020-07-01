
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Jumping Rivers R Package Repository

This is an R package repository for the [Jumping
Rivers](www.jumpingrivers.com) training courses. While this repository
is public, it’s primarily purpose is internal to Jumping Rivers.

### Creating a new package

  - Create a new [repository](https://github.com/jr-packages) with the
    correct package name: `jrXxxx`
  - On travis:
      - add the secure variable `GITHUB_PAT` (ask Colin). The
        `GITHUB_PAT` variable is needed to push packages to this drat
        repo.
      - ensure [travis](https://travis-ci.org/profile/jr-packages) will
        build your package. You’ll need to sync your account to pick up
        the package.
  - Clone the directory
  - Copy the contents of the `jrXxxx` directory to a new directory
      - Replace XXX in the DESCRIPTION file and in the
        `R/jrXxx-package.R` file
      - Update README.md
  - Push to GitHub
  - Add your package to the list below.
      - Add package name to the correct vector in the README.Rmd file
        and knit the file
      - (Please keep it in alphabetical
order)

### Current Packages

| Package                                                         | Build Status                                                                                                                  |
| :-------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| [jrAdvanced](https://github.com/jr-packages/jrAdvanced)         | [![Build Status](https://api.travis-ci.org/jr-packages/jrAdvanced.png?branch=master)](https://travis-ci.org/jr-packages/)     |
| [jrAnalytics](https://github.com/jr-packages/jrAnalytics)       | [![Build Status](https://api.travis-ci.org/jr-packages/jrAnalytics.png?branch=master)](https://travis-ci.org/jr-packages/)    |
| [jrAutomate](https://github.com/jr-packages/jrAutomate)         | [![Build Status](https://api.travis-ci.org/jr-packages/jrAutomate.png?branch=master)](https://travis-ci.org/jr-packages/)     |
| [jrBig](https://github.com/jr-packages/jrBig)                   | [![Build Status](https://api.travis-ci.org/jr-packages/jrBig.png?branch=master)](https://travis-ci.org/jr-packages/)          |
| [jrEfficient](https://github.com/jr-packages/jrEfficient)       | [![Build Status](https://api.travis-ci.org/jr-packages/jrEfficient.png?branch=master)](https://travis-ci.org/jr-packages/)    |
| [jrGgplot2](https://github.com/jr-packages/jrGgplot2)           | [![Build Status](https://api.travis-ci.org/jr-packages/jrGgplot2.png?branch=master)](https://travis-ci.org/jr-packages/)      |
| [jrIntroBio](https://github.com/jr-packages/jrIntroBio)         | [![Build Status](https://api.travis-ci.org/jr-packages/jrIntroBio.png?branch=master)](https://travis-ci.org/jr-packages/)     |
| [jrIntroduction](https://github.com/jr-packages/jrIntroduction) | [![Build Status](https://api.travis-ci.org/jr-packages/jrIntroduction.png?branch=master)](https://travis-ci.org/jr-packages/) |
| [jrIntroductionRSS](https://github.com/jr-packages/jrIntroductionRSS) | [![Build Status](https://api.travis-ci.org/jr-packages/jrIntroductionRSS.png?branch=master)](https://travis-ci.org/jr-packages/) |
| [jrModelling](https://github.com/jr-packages/jrModelling)       | [![Build Status](https://api.travis-ci.org/jr-packages/jrModelling.png?branch=master)](https://travis-ci.org/jr-packages/)    |
| [jrNotes](https://github.com/jr-packages/jrNotes)               | [![Build Status](https://api.travis-ci.org/jr-packages/jrNotes.png?branch=master)](https://travis-ci.org/jr-packages/)        |
| [jrPredictive](https://github.com/jr-packages/jrPredictive)     | [![Build Status](https://api.travis-ci.org/jr-packages/jrPredictive.png?branch=master)](https://travis-ci.org/jr-packages/)   |
| [jrProgBio](https://github.com/jr-packages/jrProgBio)           | [![Build Status](https://api.travis-ci.org/jr-packages/jrProgBio.png?branch=master)](https://travis-ci.org/jr-packages/)      |
| [jrProgramming](https://github.com/jr-packages/jrProgramming)   | [![Build Status](https://api.travis-ci.org/jr-packages/jrProgramming.png?branch=master)](https://travis-ci.org/jr-packages/)  |
| [jrPresentation](https://github.com/jr-packages/jrPresentation) | [![Build Status](https://api.travis-ci.org/jr-packages/jrPresentation.png?branch=master)](https://travis-ci.org/jr-packages/) |
| [jrRmd](https://github.com/jr-packages/jrRmd)                 | [![Build Status](https://api.travis-ci.org/jr-packages/jrRmd.png?branch=master)](https://travis-ci.org/jr-packages/)         |
| [jrRstan](https://github.com/jr-packages/jrRstan)                 | [![Build Status](https://api.travis-ci.org/jr-packages/jrRstan.png?branch=master)](https://travis-ci.org/jr-packages/)         |
| [jrShiny](https://github.com/jr-packages/jrShiny)               | [![Build Status](https://api.travis-ci.org/jr-packages/jrShiny.png?branch=master)](https://travis-ci.org/jr-packages/)        |
| [jrSpatial](https://github.com/jr-packages/jrSpatial)           | [![Build Status](https://api.travis-ci.org/jr-packages/jrSpatial.png?branch=master)](https://travis-ci.org/jr-packages/)      |
| [jrSql](https://github.com/jr-packages/jrSql)                   | [![Build Status](https://api.travis-ci.org/jr-packages/jrSql.png?branch=master)](https://travis-ci.org/jr-packages/)          |
| [jrTidyverse](https://github.com/jr-packages/jrTidyverse)       | [![Build Status](https://api.travis-ci.org/jr-packages/jrTidyverse.png?branch=master)](https://travis-ci.org/jr-packages/)    |
| [jrTidyverse2](https://github.com/jr-packages/jrTidyverse2)     | [![Build Status](https://api.travis-ci.org/jr-packages/jrTidyverse2.png?branch=master)](https://travis-ci.org/jr-packages/)   |
| [jrWhyR](https://github.com/jr-packages/jrWhyR)                 | [![Build Status](https://api.travis-ci.org/jr-packages/jrWhyR.png?branch=master)](https://travis-ci.org/jr-packages/)         |

### Other R Packages

| Packages                                                              | Build Status                                                                                                                     |
| :-------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------- |
| [efficientTutorial](https://github.com/jr-packages/efficientTutorial) | [![Build Status](https://api.travis-ci.org/jr-packages/efficientTutorial.png?branch=master)](https://travis-ci.org/jr-packages/) |

### To do

Scrape package names automatically
