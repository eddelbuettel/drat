
##' The function moves older versions of packages into a CRAN-style
##' archive folder.
##'
##' This function is still undergoing development and polish and may
##' change in subsequent versions.
##'
##' @title Move older copies of packages to an archive
##' @importFrom stringr str_extract
##' @param repopath Character variable with the path to the repo;
##' defaults to the value of the \dQuote{dratRepo} option with
##' \dQuote{"~/git/drat"} as fallback
##' @param type Character variable for the type of repository, so far
##'  \dQuote{source}, \dQuote{win.binary}, \dQuote{mac.binary},
##'  \dQuote{mac.binary.mavericks} or \dQuote{mac.binary.el-capitan}
##' @param pkg Optional character variable specifying a package name(s), whose
##' older versions should be archived. If missing (the default), archiving is
##' performed on all packages.
##' @param version R version information in the format \code{X.Y} or
##'   \code{X.Y.Z}. Only used, if archiving binary packages.
##'   By default all R versions found in the respective CRAN-like directory
##'   for the chosen `type` are checked.
##' @examples
##' \dontrun{
##'   archivePackages()   # archive all older package versions
##'   archivePackages(pkg = "drat")  # archive older copies of just one package
##' }
##' @author Thomas J. Leeper
archivePackages <- function(repopath = getOption("dratRepo", "~/git/drat"),
                            type = c(
                                "source", "mac.binary", "mac.binary.el-capitan",
                                "mac.binary.mavericks", "win.binary"
                            ),
                            pkg = NULL,
                            version = NULL) {
    
    for (type in type) {
        
        # if no R version is supplied, the one from the
        # respective "type" directory is scraped
        if (is.null(version)) {
            if (grepl("binary", type)) {
                r_versions <- stringr::str_extract(list.dirs(gsub(
                    "/[0-9].[0-9]$", "",
                    contrib.url(repopath, type)
                ), recursive = FALSE), "[0-9].[0-9]$")
            } else {
                # no version for source packages
                r_versions <- ""
            }
        } else {
            r_versions <- stringr::str_extract(
                contrib.url2(repopath, type, version),
                "[0-9].[0-9]$"
            )
        }
        
        repodir <- gsub("[0-9].[0-9]$", "", contrib.url2(repopath, type, version))
        
        for (i in r_versions) {
            archive <- file.path(paste0(repodir, i), "Archive")
            if (!file.exists(archive)) {
                if (!dir.create(archive, recursive = TRUE)) {
                    stop("Archive directory not found and couldn't be created\n", call. = FALSE)
                }
            }
            
            mkArchive <- function(x) {
                parchive <- file.path(paste0(repodir, i), "Archive", x)
                if (!file.exists(parchive)) {
                    if (!dir.create(parchive, recursive = TRUE)) {
                        stop("Package archive directory for ", x, " not found and couldn't be created\n", call. = FALSE)
                    }
                }
            }
            
            if (is.null(pkg)) {
                old <- pruneRepo(repopath = repopath, type = type, version = i, remove = FALSE)
                if (is.null(old)) next
                old <- old[!old[, "newest"], ]
                sapply(unique(old$package), mkArchive)
            } else {
                pkg <- unique(pkg)
                old <- pruneRepo(repopath = repopath, type = type, pkg = pkg, version = i, remove = FALSE)
                old <- old[!old[, "newest"] & old[, "package"] %in% pkg, ]
                sapply(pkg, mkArchive)
            }
            file.rename(file.path(repodir, i, old$file), file.path(repodir, i, "Archive", old$package, old$file))
        }
        
    }
    return(invisible(NULL))
}
