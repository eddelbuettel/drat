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
##' \sQuote{alturl} (and assigned to \sQuote{account}.
##'
##'
##' An aliased function \code{add} is also available, but not exported
##' via \code{NAMESPACE} to not clobber a possibly unrelated function;
##' use it via \code{drat:::add()}.
##' @title Add a (drat) repository to the current session
##' @aliases drat:::add
##' @param account Character vector with one or more GitHub account for
##' which a \sQuote{drat} archive is to be added.
##' @param alturl Alternative repo specification with a complete url
##' string. If \sQuote{alturl} is provided, a single \sQuote{account}
##' must be provided as well.  For file-based access, the URL format
##' has to follow the \code{file:/some/path/} format starting with
##' \sQuote{file} followed by a single colon.
##' @param ... For the aliases variant, a catch-all collection of
##' parameters.
##' @return The altered set of repositories
##' @examples
##' \dontrun{
##'   addRepo("drat")                            # adds GitHub repo via default URL
##'   addRepo(c("eddelbuettel", "ghrr"))         # ditto but adds two repos at once
##'
##'   addRepo("LocalRepo", "file:/nas/R/repo")   # adds local file-based repo,
##'                                              # assumes you can read /nas/R/repo
##' }
##' @author Dirk Eddelbuettel
addRepo <- function(account, alturl) {
    r <- getOption("repos")
    if (!missing(account) && missing(alturl)) {
        for (acct in account) {
            r[acct] <- paste0("http://", acct, ".github.io/drat/")
        }
    } else if (!missing(account) && !missing(alturl)) {
        if (.Platform$OS.type == "windows") {
            if (grepl(' ', alturl, fixed=TRUE)) {
                stop("The path '", alturl, "' contains spaces which is not permitted.", call.=FALSE)
            }
        }
        r[account] <- alturl
    } else {
        stop("Please provide either 'account' (and if desired 'alturl').", call.=FALSE)
    }
    options(repos = r)
    invisible(r)
}

##' @rdname addRepo
add <- function(...) addRepo(...)

