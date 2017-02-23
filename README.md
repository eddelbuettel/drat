
Jumping Rivers R Package Repository
-----------------------------------

This is an R package repository for the [Jumping Rivers](www.jumpingrivers.com) training courses. While this repository is public, it's primarily purpose is internal to Jumping Rivers.

### Creating a new package

-   Create a new [repository](https://github.com/jr-packages) with the correct package name: `jrXxxx`
-   On travis:
    -   add the secure variable `GITHUB_PAT` (ask Colin). The `GITHUB_PAT` variable is needed to push packages to this drat repo.
    -   ensure [travis](https://travis-ci.org/profile/jr-packages) will build your package. You'll need to sync your account to pick up the package.
-   Clone the directory
-   Copy the contents of the `jrXxxx` directory to a new directory
    -   Replace XXX in the DESCRIPTION file and in the `R/jrXxx-package.R` file
    -   Update README.md
-   Push to GitHub
-   Add you package to the list below.

### Current Packages

-   [jrIntroduction](https://github.com/jr-packages/jrIntroduction)
-   [jrProgramming](https://github.com/jr-packages/jrProgramming)
