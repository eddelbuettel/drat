##' R can use multiple archives: CRAN, BioConductor and Omegahat have
##' been supported for years.  It is equally easy to add local
##' archives from the same machine, or local network, or university /
##' company network as well as other publically available
##' repositories.  This function aids in the process, and defaults to
##' inserting a given source archive into a given repository.
##'
##' This function inserts the given package file into the given
##' (local) package repository and updates the index. One can then
##' push to remote such as GitHub.
##'
##' An aliased function \code{insert} is also available, but not
##' exported via \code{NAMESPACE} to not clobber a possibly unrelated
##' function; use it via \code{drat:::insert()}.
##' @title Insert a package source archive into a drat repository
##' @aliases drat:::insert
##' @param file A source archive in \code{tar.gz} form.
##' @param repodir A local directory corresponding to the repository
##' top-leve directory.
##' @param commit A boolean toggle to select automatic git operations
##' \sQuote{add}, \sQuote{commit}, and \sQuote{push}.
##' @param ... For the aliases variant, a catch-all collection of
##' parameters.
##' @return NULL is returned.
##' @author Dirk Eddelbuettel
insertPackage <- function(file,
                          repodir=getOption("dratRepo", "~/git/drat"),
                          commit=FALSE) {

    if (!file.exists(file)) stop("File ", file, " not found\n", .Call=FALSE)
    
    ## TODO: make src/contrib if needed
    if (!file.exists(repodir)) stop("Directory ", repodir, " not found\n", .Call=FALSE)

    srcdir <- file.path(repodir, "src", "contrib")
    if (!file.exists(srcdir)) stop("Directory ", srcdir, " not found\n", .Call=FALSE)


    file.copy(file, srcdir, overwrite=TRUE)

    write_PACKAGES(srcdir, type="source")
    ## TODO: generalize to binary

    if (commit && length(Sys.which("git") > 0)) {
        setwd(repodir)
        cmd <- sprintf("git add %s; git commit -m\"adding %s to drat\"; git push", file, file)
        system(cmd) ## TODO: error checking
    }
    invisible(NULL)
}


    
##' @rdname insertPackage
insert <- function(...) insertPackage(...)
