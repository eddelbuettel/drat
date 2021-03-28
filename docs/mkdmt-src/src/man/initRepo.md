## Intialize a git repo for drat

### Description

This helper function create a new repository, creates and checks out
‘gh-pages’ branch and fills it with the required path.

### Usage

    initRepo(name = "drat", basepath = "~/git")

### Arguments

| Argument   | Description                                                                                                                    |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `name`     | A character variable with the name the new repository, the default is “drat”.                                                  |
| `basepath` | A character variable with path to the directory in which the new repository is to be created. The default value is “"\~/git"”. |

### Details

Currently only ‘src/contrib’ for source repositories is supported.

This function is still undergoing development and polish and may change
in subsequent versions.

### Value

The function is invoked for its side-effects and only returns `NULL`
invisibly.

### Author(s)

Dirk Eddelbuettel
