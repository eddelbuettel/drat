##' R can use multiple archives: CRAN, BioConductor and Omegahat have
##' been supported for years.  It is equally easy to add local
##' archives from the same machine, or local network, or university /
##' company network as well as other publically available
##' repositories.  This function aids in the process, and defaults to
##' adding a \sQuote{drat} archive at GitHub under the given account.
##'
##' This function retrieves the current set of repositories and adds
##' (or overwrites) the entry for the given \sQuote{account}. For
##' non-GitHub repositories an alternative URL can be specified as
##' \sQuote{alturl}.  Exactly one of \sQuote{account} or
##' \sQuote{alturl} must be provided.
##' @title Add a (drat) repository to the current session
##' @param account GitHub account for which a \sQuote{drat} archive
##' is to be added.
##' @param alturl Alternative repo specification with a complete url
##' string. Exactly one of \sQuote{account} or \sQuote{alturl} must be
##' provided.
##' @return The altered set of repositories
##' @author Dirk Eddelbuettel
add <- function(account, alturl) {
    r <- getOption("repos")
    if (!missing(account) && missing(alturl)) {
        r[account] <- paste0("https://", account, ".github.io/drat/")
    } else if (missing(account) && !missing(alturl)) {
        r[account] <- alturl
    } else {
        stop("Please provide either 'account' or 'alturl'.", call.=FALSE)
    }
    options(repos = r)
    invisible(r)
}
