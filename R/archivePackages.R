
DRAT_ARCHIVE_SUB_DIR <- "Archive"

DRAT_BINARY_TYPES <- c("mac.binary","mac.binary.el-capitan",
                       "mac.binary.mavericks", "win.binary")
DRAT_BOTH_TYPES <- c("source", "mac.binary","mac.binary.el-capitan",
                     "mac.binary.mavericks", "win.binary")

DRAT_VERSION_REGEX <- "[0-9]\\.[0-9]$"
DRAT_CONTRIB_VERSION_REGEX <- paste0("contrib/",DRAT_VERSION_REGEX)

.check_path <- function(repopath){
    if(!dir.exists(repopath)){
        stop("Directory '",repopath,"' does not exist or cannot be accessed.",
             call. = FALSE)
    }
}

.norm_type <- function(type){
    type <- match.arg(type,c("source", "binary", "mac.binary","mac.binary.el-capitan",
                             "mac.binary.mavericks", "win.binary", "both"), 
                      several.ok = TRUE)
    if("both" %in% type){
        return(DRAT_BOTH_TYPES)
    }
    if("binary" %in% type){
        type <- c(type,DRAT_BINARY_TYPES)
        type <- type[type != "binary"]
        type <- unique(type)
    }
    type
}

.norm_pkg <- function(pkg){
    if(missing(pkg)){
        pkg <- NULL
    } else {
        pkg <- unique(pkg)
    }
    pkg
}

##' The function moves older versions of packages into a CRAN-style 
##' archive folder.
##' 
##' This function is still undergoing development and polish and may
##' change in subsequent versions.
##'
##' @title Move older copies of packages to an archive
##' @name archivePackages
##' @param repopath Character variable with the path to the repo;
##' defaults to the value of the \dQuote{dratRepo} option with
##' \dQuote{"~/git/drat"} as fallback
##' @param type Character variable for the type of repository, so far
##'  \dQuote{source}, \dQuote{binary}, \dQuote{win.binary}, \dQuote{mac.binary}, 
##'  \dQuote{mac.binary.mavericks}, \dQuote{mac.binary.el-capitan} or 
##'  \dQuote{both}
##' @param pkg Optional character variable specifying a package name(s), whose
##' older versions should be archived. If missing (the default), archiving is 
##' performed on all packages.
##' @param version R version information in the format \code{X.Y} or 
##'   \code{X.Y.Z}. Only used, if archiving binary packages.
##'   (default: \code{version = getRversion()}). If \code{version = NA}, all
##'   available R versions will be used. If \code{version = NULL}, this defaults
##'   to \code{getRversion()}.
##' @examples
##' \dontrun{
##'   archivePackages()   # archive all older package versions
##'   archivePackages(pkg = "drat")  # archive older copies of just one package
##' }
##' @author Thomas J. Leeper
NULL

##' @rdname archivePackages
archivePackages <- function(repopath = getOption("dratRepo", "~/git/drat"),
                            type = c("source", "binary", "mac.binary", "mac.binary.el-capitan",
                                     "mac.binary.mavericks", "win.binary", "both"),
                            pkg,
                            version = getRversion()) {
    # input check
    .check_path(repopath)
    type <- .norm_type(type)
    pkg <- .norm_pkg(pkg)
    # get repo info
    repoinfo <- getRepoInfo(repopath = repopath, type = type, pkg = pkg,
                            version = version)
    # subset to non-newest result
    repoinfo <- repoinfo[!repoinfo[,"newest"], ]
    # prepare archive directories
    .prepare_archive_directory(unique(repoinfo$contrib.url))
    # make package specific directory
    mapply(.make_archive_directory, repoinfo$contrib.url, repoinfo$package)
    # move each package
    mapply(.move_to_archive_directory, repoinfo$contrib.url, repoinfo$package,
           repoinfo$file)
    # update 
    if(nrow(repoinfo) >= 1L){
        updateRepo(repopath, type = unique(repoinfo$type), version = version)
    }
    invisible(NULL)
}

# if a repodir exists at a an archive subdirectory to it. Otherwise leave it 
# alone
.prepare_archive_directory <- function(repodir){
    archive <- file.path(repodir, DRAT_ARCHIVE_SUB_DIR)[file.exists(file.path(repodir))]
    archive_exits <- file.exists(archive)
    if (any(!archive_exits)) {
        archive <- archive[!archive_exits]
        archive_created <- vapply(archive, dir.create, logical(1), recursive = TRUE)
        if (any(!archive_created)) {
            stop("Archive directory not found and couldn't be created\n", call. = FALSE)
        }
    }
}

# each repo gets its own subdirectory in the archive subfolder
.make_archive_directory <- function(rd, pkg) {
    parchive <- file.path(rd, DRAT_ARCHIVE_SUB_DIR, pkg)
    if (!file.exists(parchive)) {
        if (!dir.create(parchive, recursive = TRUE)) {
            stop("Package archive directory for ", pkg," not found and couldn't be created\n",
                 call. = FALSE)
        }
    }
    parchive
}

# move each package
.move_to_archive_directory <- function(rd, pkg, file) {
    file.rename(file.path(rd, file),
                file.path(rd, DRAT_ARCHIVE_SUB_DIR, pkg, file))
}

##' @rdname archivePackages
archivePackagesForAllRversions <- function(repopath = getOption("dratRepo", "~/git/drat"),
                                           type = c("source", "binary", "mac.binary", "mac.binary.el-capitan",
                                                    "mac.binary.mavericks", "win.binary", "both"),
                                           pkg){
    archivePackages(repopath = repopath, type = type, pkg = pkg, version = NA)
}