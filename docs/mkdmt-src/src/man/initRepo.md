## Intialize a git repo for drat

### Description

This helper function creates a new repository, creates and checks out
the default GitHub Pages location (either the ‘gh-pages’ branch or
directory ‘docs’) and fills it with the required new paths.

### Usage

    initRepo(name = "drat", basepath = getOption("dratDirectory", "~/git"),
      location = getOption("dratBranch", "gh-pages"))

### Arguments

| Argument   | Description                                                                                                                                                                                                        |
|------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`     | A character variable with the name the new repository, the default is “drat”.                                                                                                                                      |
| `basepath` | A character variable with path to the directory in which the new repository is to be created. The default value is “~/git” and can be overriden via option ‘dratDirectory’.                                        |
| `location` | A character variable with the GitHub Pages location: either “gh-pages” indicating a branch of that name, or “docs/” directory in the main branch. The default value can be overridden via the “dratBranch” option. |

### Details

Currently only ‘src/contrib’ for source repositories is supported by
this function. The `insertPackage()` function knows to deal with
binaries for different architectures.

This function is still undergoing development and polish and may change
in subsequent versions.

### Value

The function is invoked for its side-effects and only returns `NULL`
invisibly.

### Author(s)

Dirk Eddelbuettel
