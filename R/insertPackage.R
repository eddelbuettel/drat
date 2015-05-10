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
##' @param ... For the aliases variant, a catch-all collection of
##' parameters.
##' @return NULL is returned.
##' @examples
##' \dontrun{
##'   insertPackage("foo_0.2.3.tar.gz")   # inserts into (default) repo
##'   insertPackage("foo_0.2.3.tar.gz", "/nas/R/")  # ... into local dir
##' }
##' @author Dirk Eddelbuettel
insertPackage <- function(file,
                          repodir=getOption("dratRepo", "~/git/drat"),
                          commit=FALSE) {

    if (!file.exists(file)) stop("File ", file, " not found\n", .Call=FALSE)

    ## TODO src/contrib if needed, preferably via git2r
    if (!file.exists(repodir)) stop("Directory ", repodir, " not found\n", .Call=FALSE)

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
    reldir <- getPathForPackageType(pkgtype)

    pkgdir <- file.path(repodir, reldir)

    if (!file.exists(pkgdir)) {
        ## TODO: this could be in a git branch, need checking
        if (!dir.create(pkgdir, recursive = TRUE)) {
            stop("Directory ", pkgdir, " couldn't be created\n", .Call=FALSE)
        }
    }

    ## copy file into repo
    if (!file.copy(file, pkgdir, overwrite=TRUE)) {
        stop("File ", file, " can not be copied to ", pkgdir, .Call=FALSE)
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
                    .Call=FALSE)
        }
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
        stop("Unknown package type", .Call=FALSE)
    }
    return(ret)
}

##' This function returns the directory path (relative to 
##' the repo root) where the package needs to be copied to.
##'
##' @title Get relative path for package type
##' @param pkgtype The package type as a string.
##' @param rversion String which identifies the major.minor 
### R version, which was used to build this package. Defaults 
##' to the version of the current interpreter.
##' @return string Relative file path where packages of 
##' this type should be copied to.
##' @author Jan Schulz and Dirk Eddelbuettel
getPathForPackageType <- function(pkgtype, rversion) {
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
        file.path("bin", "macosx", "contrib", rversion)
    }
    return(ret)
}
