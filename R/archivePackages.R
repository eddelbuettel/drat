
##' The function moves older versions of packages into a CRAN-style 
##' archive folder.
##' 
##' This function is still undergoing development and polish and may
##' change in subsequent versions.
##'
##' @title Move older copies of packages to an archive
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
##'   (default: \code{version = getRversion()})
##' @examples
##' \dontrun{
##'   archivePackages()   # archive all older package versions
##'   archivePackages(pkg = "drat")  # archive older copies of just one package
##' }
##' @author Thomas J. Leeper
archivePackages <- function(repopath = getOption("dratRepo", "~/git/drat"),
                            type = "source", 
                            pkg,
                            version = getRversion()) {
    
    ## knows how to handle binary repos
    repodir <- contrib.url2(repopath, type, version)

    archive <- file.path(repodir, "Archive")
    if (!file.exists(archive)) {
        if (!dir.create(archive, recursive = TRUE)) {
            stop("Archive directory not found and couldn't be created\n", call. = FALSE)
        }
    }
    
    mkArchive <- function(x) {
        parchive <- file.path(repodir, "Archive", x)
        if (!file.exists(parchive)) {
            if (!dir.create(parchive, recursive = TRUE)) {
                stop("Package archive directory for ", x," not found and couldn't be created\n", call. = FALSE)
            }
        }
    }
    
    if (missing(pkg)) {
        old <- pruneRepo(repopath = repopath, type = type, version = version,
                         remove = FALSE)
        old <- old[!old[,"newest"], ]
        sapply(unique(old$package), mkArchive)
    } else {
        pkg <- unique(pkg)
        old <- pruneRepo(repopath = repopath, type = type, pkg = pkg,
                         version = version, remove = FALSE)
        old <- old[!old[,"newest"] & old[,"package"] %in% pkg, ]
        sapply(pkg, mkArchive)
    }
    file.rename(file.path(repodir, old$file), file.path(repodir, "Archive", old$package, old$file))
    
    invisible(NULL)
}

