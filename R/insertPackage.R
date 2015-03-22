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
    
    ## TODO: make src/contrib if needed
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
        if (haspkg) {
            repo <- git2r::repository(repodir)
            setwd(srcdir)
            git2r::add(repo, file.path("src", "contrib", pkg))
            git2r::add(repo, file.path("src", "contrib", "PACKAGES"))
            git2r::add(repo, file.path("src", "contrib", "PACKAGES.gz"))
            git2r::commit(repo, msg)
            #TODO: authentication woes?   git2r::push(repo)  
            message("Added and committed ", pkg, " plus PACKAGES files. Still need to push.\n") 
        } else if (hascmd) {
            setwd(srcdir)
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
