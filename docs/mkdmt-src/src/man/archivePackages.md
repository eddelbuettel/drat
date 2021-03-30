## Move older copies of packages to an archive

### Description

The function moves older versions of packages into a CRAN-style archive
folder.

### Usage

    archivePackages(repopath = getOption("dratRepo", "~/git/drat"),
      type = c("source", "binary", "mac.binary", "mac.binary.el-capitan",
      "mac.binary.mavericks", "win.binary", "both"), pkg, version = getRversion())

    archivePackagesForAllRversions(repopath = getOption("dratRepo", "~/git/drat"),
      type = c("source", "binary", "mac.binary", "mac.binary.el-capitan",
      "mac.binary.mavericks", "win.binary", "both"), pkg)

### Arguments

| Argument   | Description                                                                                                                                                                                                                                           |
|------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `repopath` | Character variable with the path to the repo; defaults to the value of the “dratRepo” option with “"~/git/drat"” as fallback                                                                                                                          |
| `type`     | Character variable for the type of repository, so far “source”, “binary”, “win.binary”, “mac.binary”, “mac.binary.mavericks”, “mac.binary.el-capitan” or “both”                                                                                       |
| `pkg`      | Optional character variable specifying a package name(s), whose older versions should be archived. If missing (the default), archiving is performed on all packages.                                                                                  |
| `version`  | R version information in the format `X.Y` or `X.Y.Z`. Only used, if archiving binary packages. (default: `version = getRversion()`). If `version = NA`, all available R versions will be used. If `version = NULL`, this defaults to `getRversion()`. |

### Details

This function is still undergoing development and polish and may change
in subsequent versions.

### Author(s)

Thomas J. Leeper

### Examples

    ## Not run: 
      archivePackages()   # archive all older package versions
      archivePackages(pkg = "drat")  # archive older copies of just one package

    ## End(Not run)
