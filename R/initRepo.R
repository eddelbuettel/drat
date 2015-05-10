

initRepo <- function(basepath="~/git",
                     name="drat") {

    dir <- file.path(basepath, name)
    if (file.exists(dir)) stop("Directory '", dir, "' already exists.", call.=FALSE)

    dir.create(dir)
    repo <- init(dir)

    writeLines("## Drat Repo", file.path(dir, "README.md"))
    add(repo, "README.md")
    cmt <- commit(repo, "Initial Commit")

    checkout(repo, "gh-pages", create=TRUE)
    
    dir.create(file.path(dir, "src"))
    dir.create(file.path(dir, "src", "contrib"))
    ## create binary path as well ?
}
