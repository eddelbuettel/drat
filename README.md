
Jumping Rivers R Package Repository
-----------------------------------

This is an R package repository for the [Jumping Rivers](www.jumpingrivers.com) training courses. While this repository is public, it's primarily purpose is internal to Jumping Rivers.

### Creating a new package

-   The package name should have the prefix `jr`, followed by a capital letter.
-   Copy the `.gitignore` and `.RbuildIgnore` to the new package from this `drat` repository. If you update these files, please consider updating the drat master copies.
-   Copy the `.travis.yml` from this repository to your page. If there is a `Makefile` to run before the build need to uncomment out `before_script`
-   On travis:
    -   add the secure variable `GITHUB_PAT` (ask Colin)
    -   ensure [travis](https://travis-ci.org/profile/jr-packages) will build your package

### Current Packages

-   [jrProgramming](https://github.com/jr-packages/jrProgramming)
