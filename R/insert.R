##' R can use multiple archives: CRAN, BioConductor and Omegahat have
##' been supported for years.  It is equally easy to add local
##' archives from the same machine, or local network, or university /
##' company network as well as other publically available
##' repositories.  This function aids in the process, and defaults to
##' inserting a given source archive into a given repository.
##'
##' This function inserts the given file into the given (local)
##' repository and updates the index. One can then push to remote
##' such as GitHub.
##' @title Insert a source archive into a drat repository
##' @param file A source archive in \code{tar.gz} form.
##' @param repodir A local directory corresponding to the repository
##' top-leve directory.
##' @param commit A boolean toggle to select automatic git operations
##' \sQuote{add}, \sQuote{commit}, and \sQuote{push}.
##' @return NULL is returned.
##' @author Dirk Eddelbuettel
insert <- function(file,
                   repodir=getOption("dratRepo", "~/git/drat"),
                   commit=FALSE) {

    if (!file.exists(file)) stop("File ", file, " not found\n", .Call=FALSE)

    ## TODO: make src/contrib if needed
    srcdir <- file.path(repodir, "src", "contrib")
    if (!file.exists(repodir)) stop("Directory ", repodir, " not found\n", .Call=FALSE)

    tgtfile <- file.path(srcdir, file)
    file.copy(file, tgtfile, overwrite=TRUE)

    write_PACKAGES(srcdir, type="source")
    ## TODO: generalize to binary

    if (commit && length(Sys.which("git") > 0)) {
        setwd(repodir)
        cmd <- sprintf("git add %s; git commit -m\"adding %s to drat\"; git push", file, file)
        system(cmd) ## TODO: error checking
    }
    invisible(NULL)
}
    
