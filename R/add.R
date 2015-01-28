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
##' @param account Character vector with one or more GitHub account for
##' which a \sQuote{drat} archive is to be added.
##' @param alturl Alternative repo specification with a complete url
##' string. If \sQuote{alturl} is provided, a single \sQuote{account}
##' must be provided as well.
##' @return The altered set of repositories
##' @author Dirk Eddelbuettel
add <- function(account, alturl) {
    r <- getOption("repos")
    if (!missing(account) && missing(alturl)) {
        for (acct in account) {
            r[acct] <- paste0("https://", acct, ".github.io/drat/")
        }
    } else if (!missing(account) && !missing(alturl)) {
        r[account] <- alturl
    } else {
        stop("Please provide either 'account' (and if desired 'alturl').", call.=FALSE)
    }
    options(repos = r)
    invisible(r)
}
