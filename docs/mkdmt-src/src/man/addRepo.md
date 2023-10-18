
## Add a (drat) repository to the current session

### Description

R can use multiple archives: CRAN, BioConductor and Omegahat have been
supported for years. It is equally easy to add local archives from the
same machine, or local network, or university / company network as well
as other publically available repositories. This function aids in the
process, and defaults to adding a ‘drat’ archive at GitHub under the
given account.

### Usage

``` R
addRepo(account, alturl)

add(...)
```

### Arguments

|           |                                                                                                                                                                                                                                                                     |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `account` | Character vector with one or more GitHub account for which a ‘drat’ archive is to be added.                                                                                                                                                                         |
| `alturl`  | Alternative repo specification with a complete url string. If ‘alturl’ is provided, a single ‘account’ must be provided as well. For file-based access, the URL format has to follow the `file:/some/path/` format starting with ‘file’ followed by a single colon. |
| `...`     | For the aliases variant, a catch-all collection of parameters.                                                                                                                                                                                                      |

### Details

This function retrieves the current set of repositories (see
`getOption("repos")` for the current values) and adds (or overwrites)
the entry for the given ‘account’. For non-GitHub repositories an
alternative URL can be specified as ‘alturl’ (and assigned to ‘account’
as well).

An aliased function `add` is also available, but not exported via
`NAMESPACE` to not clobber a possibly unrelated function; use it via
`drat:::add()`.

### Value

The altered set of repositories

### Author(s)

Dirk Eddelbuettel

### Examples

``` R
## Not run: 
  addRepo("drat")                            # adds GitHub repo via default URL
  addRepo(c("eddelbuettel", "ghrr"))         # ditto but adds two repos at once

  addRepo("LocalRepo", "file:/nas/R/repo")   # adds local file-based repo,
                                             # assumes you can read /nas/R/repo

## End(Not run)
```

