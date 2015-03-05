##' R can use multiple archives: CRAN, BioConductor and Omegahat have
##' been supported for years.  It is equally easy to add local
##' archives from the same machine, or local network, or university /
##' company network as well as other publically available
##' repositories.  This function aids in the process, and defaults to
##' inserting a given source archive into a given repository.
##'
##' This function inserts the given package file into the given
##' (local) package repository and updates the index. By setting the
##' \code{commit} option to \code{TRUE}, one can then push to a remote
##' git code repository. If the \code{\link[git2r]{git2r}} package is
##' installed, it is used for the interaction with the git repository;
##' otherwise the \code{git} shell command is used.
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

    ## check for the optional git2r package
    haspkg <- requireNamespace("git2r")
    hascmd <- length(Sys.which("git")) > 0

    curwd <- getwd()
    
    if (commit && haspkg) {  
        repo <- git2r::repository(repodir)
        git2r::checkout(repo, "gh-pages")
    } else if (commit && hascmd) {
        setwd(repodir)
        system("git checkout gh-pages")
        setwd(curwd)
    }
    
    ## TODO: maybe branch on Windows / OS X files
    srcdir <- file.path(repodir, "src", "contrib")
    if (!file.exists(srcdir)) stop("Directory ", srcdir, " not found\n", .Call=FALSE)

    ## copy file into repo
    if (!file.copy(file, srcdir, overwrite=TRUE)) {
        stop("File ", file, " can not be copied to ", srcdir, .Call=FALSE)
    }
    
    ## update index
    write_PACKAGES(srcdir, type="source")
    ## TODO: generalize to binary

    if (commit) {
        pkg <- basename(file)
        if (haspkg) {
            repo <- git2r::repository(repodir)
            setwd(srcdir)
            git2r::add(repo, file.path("src", "contrib", pkg))
            git2r::add(repo, file.path("src", "contrib", "PACKAGES"))
            git2r::add(repo, file.path("src", "contrib", "PACKAGES.gz"))
            git2r::commit(repo, paste("adding", pkg, "to drat"))
            # git2r::push(repo)
        } else if (hascmd) {
            setwd(srcdir)
            cmd <- sprintf(paste("git add %s PACKAGES PACKAGES.gz;",
                                 "git commit -m\"adding %s to drat\";",
                                 "git push"), pkg, pkg)
            system(cmd) ## TODO: error checking
        } else {
            warning("Commit skipped as both git2r package and git command missing.",
                    .Call=FALSE)
        }
    }
    invisible(NULL)
}


    
##' @rdname insertPackage
insert <- function(...) insertPackage(...)
