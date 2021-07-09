
##' This helper function creates a new repository, creates and checks
##' out the default GitHub Pages location (either the \sQuote{gh-pages}
##' branch or directory \sQuote{docs}) and fills it with the required
##' new paths.
##' 
##' Currently only \sQuote{src/contrib} for source repositories is
##' supported by this function. The \code{insertPackage()} function knows
##' to deal with binaries for different architectures.
##'
##' The function also installs a top-level \code{index.html} file to ensure
##' external tests against the repository (as for example done by CRAN if you
##' list the repository as an \sQuote{Additional_repositories} in a package)
##' do not return a \sQuote{404} error.
##'
##' @title Intialize a git repo for drat
##' @param name A character variable with the name the new repository,
##' the default is \dQuote{drat}.
##' @param basepath A character variable with path to the directory in
##' which the new repository is to be created. The default value is
##' \dQuote{~/git} and can be overriden via option \sQuote{dratDirectory}.
##' @param location A character variable with the GitHub Pages location:
##' either \dQuote{gh-pages} indicating a branch of that name, or
##' \dQuote{docs/} directory in the main branch. The default value can
##' be overridden via the \dQuote{dratBranch} option.
##' @return The function is invoked for its side-effects and only
##' returns \code{NULL} invisibly.
##' @author Dirk Eddelbuettel
initRepo <- function(name = "drat",
                     basepath = getOption("dratDirectory", "~/git"),
                     location = getOption("dratBranch", "gh-pages")) {

    haspkg <- requireNamespace("git2r", quietly=TRUE)
    if (!haspkg) stop("The 'initRepo' function requires the 'git2r' packages.", call.=FALSE)
    
    dir <- file.path(basepath, name)
    if (file.exists(dir)) stop("Directory '", dir, "' already exists.", call.=FALSE)

    .check_location_arg(location)

    dir.create(dir)
    repo <- git2r::init(dir)

    writeLines("## Drat Repo", file.path(dir, "README.md"))
    git2r::add(repo, "README.md")
    cmt <- git2r::commit(repo, "Initial Commit")

    if (location == "gh-pages") {
        git2r::checkout(repo, "gh-pages", create=TRUE)
    } else if (location == "docs") {
        dir <- file.path(dir, location)
        dir.create(dir)
    }

    dir.create(file.path(dir, "src"))
    dir.create(file.path(dir, "src", "contrib"))
    ## create binary path as well ?

    ## CRAN checks a repo via 'curl -I -L https:/...' which needs an index.html file
    writeLines("<!doctype html><title>empty placeholder file</title>", file.path(dir, "index.html"))

    invisible(NULL)
}
