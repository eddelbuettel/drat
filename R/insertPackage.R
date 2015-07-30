##' R can use multiple archives: CRAN, BioConductor and Omegahat have
##' been supported for years.  It is equally easy to add local
##' archives from the same machine, or local network, or university /
##' company network as well as other publically available
##' repositories.  This function aids in the process, and defaults to
##' inserting a given source archive into a given repository.
##'
##' This function inserts the given (source or binary) package file
##' into the given (local) package repository and updates the
##' index. By setting the \code{commit} option to \code{TRUE}, one can
##' then push to a remote git code repository. If the
##' \code{\link[git2r]{git2r}} package is installed, it is used for
##' the interaction with the git repository; otherwise the \code{git}
##' shell command is used.
##'
##' An aliased function \code{insert} is also available, but not
##' exported via \code{NAMESPACE} to not clobber a possibly unrelated
##' function; use it via \code{drat:::insert()}.
##' @title Insert a package source or binary file into a drat repository
##' @aliases drat:::insert
##' @param file An R package in source or binary format,
##' @param repodir A local directory corresponding to the repository
##' top-level directory.
##' @param commit Either boolean toggle to select automatic git operations
##' \sQuote{add}, \sQuote{commit}, and \sQuote{push} or, alternatively,
##' a character variable can be used to specify a commit message; this also
##' implies the \sQuote{TRUE} values in other contexts.
##' @param action A character string containing one of: \dQuote{none} 
##' (the default; add the new package into the repo, effectively masking 
##' previous versions), \dQuote{archive} (place any previous versions into 
##' a package-specific archive folder, creating such an archive if it does 
##' not already exist), or \dQuote{prune} (calling \code{\link{pruneRepo}}).
##' @param ... For the aliases variant, a catch-all collection of
##' parameters.
##' @return NULL is returned.
##' @examples
##' \dontrun{
##'   insertPackage("foo_0.2.3.tar.gz")   # inserts into (default) repo
##'   insertPackage("foo_0.2.3.tar.gz", "/nas/R/")  # ... into local dir
##' }
##' \dontrun{
##'   insertPackage("foo_0.2.3.tar.gz", action = "prune")   # prunes any older copies
##'   insertPackage("foo_0.2.3.tar.gz", action = "archive")   # archives any older copies
##' }
##' @author Dirk Eddelbuettel
insertPackage <- function(file,
                          repodir=getOption("dratRepo", "~/git/drat"),
                          commit=FALSE,
                          action=c("none", "archive", "prune")) {

    if (!file.exists(file)) stop("File ", file, " not found\n", call.=FALSE)

    ## TODO src/contrib if needed, preferably via git2r
    if (!file.exists(repodir)) stop("Directory ", repodir, " not found\n", call.=FALSE)

    ## check for the optional git2r package
    haspkg <- requireNamespace("git2r", quietly=TRUE)
    hascmd <- length(Sys.which("git")) > 0

    curwd <- getwd()
    on.exit(setwd(curwd))               # restore current working directory 

    pkg <- basename(file)
    msg <- if (isTRUE(commit)) sprintf("Adding %s to drat", pkg) else ""
    ## special case of commit via message: not TRUE, and character 
    if (!isTRUE(commit) && typeof(commit) == "character" && nchar(commit) > 0) {
        msg <- commit
        commit <- TRUE
    }
    
    if (commit && haspkg) {  
        repo <- git2r::repository(repodir)
        git2r::checkout(repo, "gh-pages")
    } else if (commit && hascmd) {
        setwd(repodir)
        system("git checkout gh-pages")
        setwd(curwd)
    }

    pkgtype <- identifyPackageType(file)
    reldir <- getPathForPackageType(pkgtype, file=file)

    pkgdir <- file.path(repodir, reldir)

    if (!file.exists(pkgdir)) {
        ## TODO: this could be in a git branch, need checking
        if (!dir.create(pkgdir, recursive = TRUE)) {
            stop("Directory ", pkgdir, " couldn't be created\n", call.=FALSE)
        }
    }

    ## copy file into repo
    if (!file.copy(file, pkgdir, overwrite=TRUE)) {
        stop("File ", file, " can not be copied to ", pkgdir, call.=FALSE)
    }
    
    ## update index
    write_PACKAGES(pkgdir, type=pkgtype)

    if (commit) {
        if (haspkg) {
            repo <- git2r::repository(repodir)
            setwd(pkgdir)
            git2r::add(repo, file.path(reldir, pkg))
            git2r::add(repo, file.path(reldir, "PACKAGES"))
            git2r::add(repo, file.path(reldir, "PACKAGES.gz"))
            tryCatch(git2r::commit(repo, msg), error = function(e) warning(e))
            #TODO: authentication woes?   git2r::push(repo)  
            message("Added and committed ", pkg, " plus PACKAGES files. Still need to push.\n") 
        } else if (hascmd) {
            setwd(pkgdir)
            cmd <- sprintf(paste("git add %s PACKAGES PACKAGES.gz;",
                                 "git commit -m\"%s\";",
                                 "git push"), pkg, msg)
            system(cmd) ## TODO: error checking
            message("Added, committed and pushed ", pkg, " plus PACKAGES files.\n") 
        } else {
            warning("Commit skipped as both git2r package and git command missing.",
                    call.=FALSE)
        }
    }
    
    action <- match.arg(action)
    pkgname <- gsub("\\.tar\\..*$", "", pkg)
    pkgname <- strsplit(pkgname, "_", fixed=TRUE)[[1L]][1L]
    if (action == "prune") {
        pruneRepo(repopath = repodir, pkg = pkgname, remove = TRUE)
    } else if (action == "archive") {
        archivePackages(repopath = repodir, pkg = pkgname)
    }
    
    invisible(NULL)
}


    
##' @rdname insertPackage
insert <- function(...) insertPackage(...)


##' This function identifies the package type from a filename.
##'
##' The returned string is suitable for \code{write_PACKAGES()}.
##' @title Identifies the package type from a filename
##' @param file An R package in source or binary format,
##' @return string Type of the supplied package.
##' @author Jan Schulz and Dirk Eddelbuettel
identifyPackageType <- function(file) {
    ##from src/library/tools/R/packages.R
    ret <- if (grepl("_.*\\.tar\\..*$", file)) {
        "source"
    } else if (grepl("_.*\\.tgz$", file)) {
        "mac.binary"
    } else if (grepl("_.*\\.zip$", file)) {
        "win.binary"
    } else {
        stop("Unknown package type", call.=FALSE)
    }
    return(ret)
}

##' This function returns the directory path (relative to 
##' the repo root) where the package needs to be copied to.
##'
##' @title Get relative path for package type
##' @param pkgtype The package type as a string.
##' @param rversion String which identifies the major.minor 
##' R version, which was used to build this package. Defaults 
##' to the version of the current interpreter.
##' @param file the fully qualified path of the package
##' @return string Relative file path where packages of 
##' this type should be copied to.
##' @author Jan Schulz and Dirk Eddelbuettel
getPathForPackageType <- function(pkgtype, rversion, file) {
    .getRVersionString <- function() {
        paste(getRversion()$major, getRversion()$minor, sep=".")
        ## or:    gsub("\\.\\d+$", "", getRversion())
        ## or:    sprintf("%s.%s", base::getRversion()$major, base::getRversion()$minor)
    }
    if (missing(rversion)) rversion <- .getRVersionString()
    ret <- if (pkgtype == "source") {
        file.path("src", "contrib")
    } else if (pkgtype == "win.binary") {
        file.path("bin", "windows", "contrib", rversion)
    } else if (pkgtype == "mac.binary") {
        getPathForMac(rversion, file)
    }
    return(ret)
}

##' This function parses the Built metadata from DESCRIPTION
##' in a package submission to determine the MacOS path for
##' binary builds.
##'
##' @title Extract R version and built architecture from package DESCRIPTION
##' @param rversion String which identifies the major.minor 
##' R version, which was used to build this package. Defaults 
##' to the version of the current interpreter.
##' @param file The fully qualified path to the package archive file
##' @return string Relative file path where packages of 
##' this type should be copied to.
##' @author Matthew Jones
getPathForMac <- function(rversion, file) {
    if (!file.exists(file)) stop("File ", file, " not found\n", call.=FALSE)
    
    # Untar the package and extract the DESCRIPTION file
    pkg <- basename(file)
    pkg_name <- sub("_.*", "", pkg)
    tf <- tempdir()
    untar(file, exdir=tf)
    
    # Find the BUILT metadata line
    description <- readLines(file.path(tf, pkg_name, "DESCRIPTION"))
    built_string <- description[grep("Built:", description)]
    unlink(file.path(tf, pkg_name), recursive=TRUE)
    #built_string <- 'Built: R 3.2.0; x86_64-apple-darwin13.4.0; 2015-07-28 01:17:32 UTC; unix'
    #built_string <- 'Built: R 3.2.0; x86_64-apple-darwin10.8.0; 2015-05-11 23:54:50 UTC; unix'
    #built_string <- 'Built: R 3.2.1; x86_64-w64-mingw32; 2015-06-30 15:08:30 UTC; windows'
    
    # TODO: Extract the built R version from BUILT
    # built <- strsplit(built_string, ';')
    # pattern <- "R (.*).."
    # rversion <- gsub(pattern, "\\1", str_extract(built[[1]][1], pattern)[[1]])
    
    # Return the correct package path based on the darwin version
    if (grepl("darwin13", built_string)) {
        file.path("bin", "macosx", "mavericks", "contrib", rversion)
    } else {
        file.path("bin", "macosx", "contrib", rversion)
    }
}

