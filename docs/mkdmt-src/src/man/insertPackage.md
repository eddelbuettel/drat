## Insert a package source or binary file into a drat repository

### Description

R can use multiple archives: CRAN, BioConductor and Omegahat have been
supported for years. It is equally easy to add local archives from the
same machine, or local network, or university / company network as well
as other publically available repositories. This function aids in the
process, and defaults to inserting a given source archive into a given
repository.

### Usage

    insertPackage(
      file,
      repodir = getOption("dratRepo", "~/git/drat"),
      commit = FALSE,
      pullfirst = FALSE,
      action = c("none", "archive", "prune"),
      location = getOption("dratBranch", "gh-pages"),
      ...
    )

    insertPackages(file, ...)

    insert(...)

### Arguments

| Argument    | Description                                                                                                                                                                                                                                                                                                    |
|-------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `file`      | One or more R package(s) in source or binary format                                                                                                                                                                                                                                                            |
| `repodir`   | A local directory corresponding to the repository top-level directory.                                                                                                                                                                                                                                         |
| `commit`    | Either boolean toggle to select automatic git operations ‘add’, ‘commit’, and ‘push’ or, alternatively, a character variable can be used to specify a commit message; this also implies the ‘TRUE’ values in other contexts.                                                                                   |
| `pullfirst` | Boolean toggle to call `git pull` before inserting the package.                                                                                                                                                                                                                                                |
| `action`    | A character string containing one of: “none” (the default; add the new package into the repo, effectively masking previous versions), “archive” (place any previous versions into a package-specific archive folder, creating such an archive if it does not already exist), or “prune” (calling `pruneRepo`). |
| `location`  | A character variable with the GitHub Pages location: either “gh-pages” indicating a branch of that name, or “docs/” directory in the main branch. The default value can be overridden via the “dratBranch” option.                                                                                             |
| `...`       | For `insert` the aliases variant, a catch-all collection of parameters. For `insertPackage` arguments passed to `write_PACKAGES` currently include `latestOnly`, for which the default value is set here to `FALSE`. See `write_PACKAGES`.                                                                     |

### Details

This function inserts the given (source or binary) package file into the
given (local) package repository and updates the index. By setting the
`commit` option to `TRUE`, one can then push to a remote git code
repository. If the `git2r` package is installed, it is used for the
interaction with the git repository; otherwise the `git` shell command
is used.

An aliased function `insert` is also available, but not exported via
`NAMESPACE` to not clobber a possibly unrelated function; use it via
`drat:::insert()`.

The function also checks for a top-level `index.html` file to ensure
external tests against the repository (as for example done by CRAN if
you list the repository as an ‘Additional\_repositories’ in a package)
do not return a ‘404’ error. If missing, a simple one-line example is
shown.

### Value

NULL is returned.

### Options

Set using `options`

`dratRepo`  
Path to git repo. Defaults to `~/git/drat`

`dratBranch`  
The git branch to store packages on. Defaults to `gh-pages`

### Author(s)

Dirk Eddelbuettel

### Examples

    ## Not run: 
      insertPackage("foo_0.2.3.tar.gz")   # inserts into (default) repo
      insertPackage("foo_0.2.3.tar.gz", "/nas/R/")  # ... into local dir

    ## End(Not run)
    ## Not run: 
      insertPackage("foo_0.2.3.tar.gz", action = "prune")   # prunes any older copies
      insertPackage("foo_0.2.3.tar.gz", action = "archive")   # archives any older copies

    ## End(Not run)
