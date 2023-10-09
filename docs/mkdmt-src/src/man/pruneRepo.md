
## Prune repository from older copies of packages

### Description

The function determines which packages in a repositories can be removed
as they are being ‘shadowed’ by a newer version of the same packages.

### Usage

``` R
getRepoInfo(
  repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "binary", "mac.binary", "mac.binary.big-sur-x86_64",
    "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
    "win.binary", "both"),
  pkg,
  version = getRversion(),
  location = getOption("dratBranch", "gh-pages")
)

pruneRepo(
  repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "binary", "mac.binary", "mac.binary.big-sur-x86_64",
    "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
    "win.binary", "both"),
  pkg,
  version = getRversion(),
  remove = FALSE,
  location = getOption("dratBranch", "gh-pages")
)

pruneRepoForAllRversions(
  repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "mac.binary", "mac.binary.big-sur-x86_64",
    "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
    "win.binary", "both"),
  pkg,
  remove = FALSE
)

updateRepo(
  repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "mac.binary", "mac.binary.big-sur-x86_64",
    "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
    "win.binary", "both"),
  version = NA,
  ...
)
```

### Arguments

|            |                                                                                                                                                                                                                                                                                                                         |
|------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `repopath` | Character variable with the path to the repo; defaults to the value of the “dratRepo” option with “"~/git/drat"” as fallback                                                                                                                                                                                            |
| `type`     | Character variable for the type of repository, so far “source”, “binary”, “win.binary”, “mac.binary”, “mac.binary.mavericks”, “mac.binary.el-capitan”, “mac.binary.big-sur-x86_64”, “mac.binary.big-sur-arm64”, or “both”                                                                                               |
| `pkg`      | Optional character variable specifying a package name, whose older versions should be pruned. If missing (the default), pruning is performed on all packages.                                                                                                                                                           |
| `version`  | R version information in the format `X.Y` or `X.Y.Z`. Only used, if pruning binary packages. (default: `version = getRversion()`). If `version = NA`, all available R versions will be used. If `version = NULL`, this defaults to `getRversion()`.                                                                     |
| `location` | An optional character variable with the GitHub Pages location: either “gh-pages” indicating a branch of that name, or “docs/” directory in the main branch. The default value can be overridden via the “dratBranch” option.                                                                                            |
| `remove`   | Character or logical variable indicating whether files should be removed. Nothing happens if ‘FALSE’. If different from (logical) ‘FALSE’ and equal to character “git” files are removed via `git rm` else via a straight file deletion.                                                                                |
| `...`      | For `updateRepo` a catch-all collection of parameters. Arguments passed to `update_PACKAGES` currently include `latestOnly`, for which the default value is set here to `FALSE`. See `update_PACKAGES`. Please note that this has an effect for `update_PACKAGES` only, if new packages are found, e.g. manually added. |

### Details

Given a package name, R will always find the newest version of that
package. Older versions are therefore effectively shadowed and can be
removed without functionally changing a repository.

However, if a current package file is removed without `pruneRepo`, the
PACKAGES, PACKAGES.gz and PACKAGES.rds file might be not up to date. To
ensure the correct information is available in these indices, run
`updateRepo`.

These functions are still undergoing development and polish and may
change in subsequent versions.

### Value

A data frame describing the repository is returned containing columns
with columns “file”, “package” (just the name), “version” and a logical
variable “newest” indicating if the package can be removed.

### Author(s)

Dirk Eddelbuettel

