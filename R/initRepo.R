
##' This helper function create a new repository, creates and checks out
##' \sQuote{gh-pages} branch and fills it with the required path for both source
##' and binary repositories. 
##'
##' This function is still undergoing development and polish and may change in
##' subsequent versions.
##'
##' @title Intialize a git repo for drat
##' @param name A character variable with the name the new repository, the
##'   default is \dQuote{drat}. If name has two parts in format of
##'   \dQuote{account_name/repo_name}, the cooresponding github repo is set as
##'   repo git remote.
##' @param basepath A character variable with path to the directory in which the
##'   new repository is to be created. The default value is \dQuote{~/git}.
##' @param remote_type Add github remote with \dQuote{SSH} or \dQuote{HTTPS}
##'   format.
##' @param push Push changes to github remote in the end if available. This may
##'   only works for SSH and when ssh-agent is available.
##' @return The function is invoked for its side-effects and only returns
##'   \code{NULL} invisibly.
##' @author Dirk Eddelbuettel
initRepo <- function(name="drat", basepath="~/git", 
                     remote_type = "SSH" , push = FALSE) {
    ## parse name
    github_acc <- NULL
    if (grepl("/", name)) {
      split_names <- strsplit(name, "/", fixed = TRUE)[[1]]
      if (length(split_names) != 2) stop("name is not valid format of 'account_name/repo_name'")
      github_acc <- split_names[1]
      name <- split_names[2]
    }
    haspkg <- requireNamespace("git2r", quietly=TRUE)
    if (!haspkg) stop("The 'initRepo' function requires the 'git2r' packages.", call.=FALSE)
    
    dir <- file.path(basepath, name)
    if (file.exists(dir)) stop("Directory '", dir, "' already exists.", call.=FALSE)

    dir.create(dir)
    repo <- git2r::init(dir)
    ## add github remote if available
    # https://github.com/account_name/repo_name.git
    # git@github.com:account_name/repo_name.git
    remote_url <- switch(remote_type,
       SSH = paste0("git@github.com:", github_acc, "/", name, ".git"),
       HTTPS = paste0("https://github.com/", github_acc, "/", name, ".git")
    )
    if (!is.null(github_acc)) git2r::remote_add(repo, "origin", remote_url)

    writeLines("## Drat Repo", file.path(dir, "README.md"))
    git2r::add(repo, "README.md")
    cmt <- git2r::commit(repo, "Initial Commit in master with README.md")

    git2r::checkout(repo, "gh-pages", create=TRUE)
    # create source path
    dir.create(file.path(dir, "src"))
    dir.create(file.path(dir, "src", "contrib"))
    ## create binary path as well
    # / should work in both windows and mac/linux
    # picked from https://cran.r-project.org/bin/windows/contrib/
    win_binary_base <- "bin/windows/contrib"
    win_r_versions <- c("3.1", "3.2", "3.3", "3.4", "3.5")
    win_binary_folders <- file.path(dir, win_binary_base, win_r_versions)
    # picked from https://cran.r-project.org/bin/macosx/
    mac_binary_bases <- list(mavericks = "bin/macosx/mavericks/contrib",
                             contrib = "bin/macosx/contrib",
                             el_capitan = "bin/macosx/el-capitan/contrib")
    mac_r_versions <- list(mavericks = c("3.1", "3.2", "3.3"),
                           contrib = c("3.0", "3.1", "3.2"),
                           el_capitan = c("3.4", "3.5"))
    mac_binary_folders <- lapply(names(mac_binary_bases), 
                                 function(x) {
                                   file.path(dir, mac_binary_bases[[x]],
                                             mac_r_versions[[x]])
                                 })
    # create folders and empty package index files
    binary_folders <- unlist(c(win_binary_folders, mac_binary_folders))
    lapply(binary_folders, function(folder) {
      message("Creating binary repositories paths")
      dir.create(folder, recursive = TRUE)
      file.create(file.path(folder, "PACKAGES"))
    })
    git2r::add(repo, ".")
    git2r::commit(repo, "Initial Commit in gh-pages with repositories paths")
    # push repo
    if (push) git2r::push(repo, name = "origin", 
                          refspec = "refs/heads/gh-pages")
    
    invisible(NULL)
}
