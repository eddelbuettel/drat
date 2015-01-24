##' R can use multiple archives: CRAN, BioConductor and Omegahat have
##' been supported for years.  It is equally easy to add local
##' archives from the same machine, or local network, or university /
##' company network as well as other publically available
##' repositories.  This function aids in the process, and defaults to
##' adding a \sQuote{drat} archive at GitHub under the given name.
##'
##' This function retrieves the current set of repositories and adds
##' (or overwrites) the entry for the given \sQuote{name}.
##' @title Add a (drat) repository to the current session
##' @param name GitHub account name for which a \sQuote{drat} archive
##' is to be added.
##' @return The altered set of repositories
##' @author Dirk Eddelbuettel
add <- function(name) {
    r <- getOption("repos")
    r[name] <- paste0("https://", name, ".github.io/drat/")
    options(repos = r)
    invisible(r)
}
