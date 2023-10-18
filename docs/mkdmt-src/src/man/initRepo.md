
## Intialize a git repo for drat

### Description

This helper function creates a new repository, creates and checks out
the default GitHub Pages location (either the ‘gh-pages’ branch or
directory ‘docs’) and fills it with the required new paths.

### Usage

``` R
initRepo(
  name = "drat",
  basepath = getOption("dratDirectory", "~/git"),
  location = getOption("dratBranch", "gh-pages")
)
```

### Arguments

|            |                                                                                                                                                                                                                    |
|------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`     | A character variable with the name the new repository, the default is “drat”.                                                                                                                                      |
| `basepath` | A character variable with path to the directory in which the new repository is to be created. The default value is “~/git” and can be overriden via option ‘dratDirectory’.                                        |
| `location` | A character variable with the GitHub Pages location: either “gh-pages” indicating a branch of that name, or “docs/” directory in the main branch. The default value can be overridden via the “dratBranch” option. |

### Details

Currently only ‘src/contrib’ for source repositories is supported by
this function. The `insertPackage()` function knows to deal with
binaries for different architectures.

The function also installs a top-level `index.html` file to ensure
external tests against the repository (as for example done by CRAN if
you list the repository as an ‘Additional_repositories’ in a package) do
not return a ‘404’ error.

### Value

The function is invoked for its side-effects and only returns `NULL`
invisibly.

### Author(s)

Dirk Eddelbuettel

