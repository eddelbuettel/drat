
##' This helper function create a new repository, creates and checks
##' out \sQuote{gh-pages} branch and fills it with the required path.
##' 
##' Currently only \sQuote{src/contrib} for source repositories is
##' supported.
##'
##' This function is still undergoing development and polish and may
##' change in subsequent versions.
##'
##' @title Intialize a git repo for drat
##' @param name A character variable with the name the new repository,
##' the default is \dQuote{drat}.
##' @param basepath A character variable with path to the directory in
##' which the new repository is to be created. The default value is
##' \dQuote{"~/git"}.
##' @return The function is invoked for its side-effects and only
##' returns \code{NULL} invisibly.
##' @author Dirk Eddelbuettel
initRepo <- function(name="drat", basepath="~/git") {

    haspkg <- requireNamespace("git2r", quietly=TRUE)
    if (!haspkg) stop("The 'initRepo' function requires the 'git2r' packages.", call.=FALSE)
    
    dir <- file.path(basepath, name)
    if (file.exists(dir)) stop("Directory '", dir, "' already exists.", call.=FALSE)

    dir.create(dir)
    repo <- git2r::init(dir)

    writeLines("## Drat Repo", file.path(dir, "README.md"))
    git2r::add(repo, "README.md")
    cmt <- git2r::commit(repo, "Initial Commit")

    git2r::checkout(repo, "gh-pages", create=TRUE)
    
    dir.create(file.path(dir, "src"))
    dir.create(file.path(dir, "src", "contrib"))
    ## create binary path as well ?

    invisible(NULL)
}
