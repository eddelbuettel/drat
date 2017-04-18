##' @title Generate basic html website based on package metadata 
##' @description Generate basic html website with basic package info, optionally includes html manual. Package installation string can be included as well. \emph{CI} environment variables for git branch and git commit will be included if available.
##' @param file An R package in source or binary format.
##' @param repodir A local directory corresponding to the repository top-level directory.
##' @param repo.url character, url to be used in \emph{repos} argument in generated \code{install.packages} call for html website.
##' @param repo.cran logical or character, default FALSE, if TRUE it will append repository list with CRAN repo in generated \code{install.packages} call.
##' @param manual logical, default FALSE, when TRUE it will copy package \emph{html} subdirectory to \emph{repodir} and add a link to \code{html/00Index.html}. Additionally \emph{DESCRIPTION} file will be copied so can be accessed from manual.
##' @return TRUE is returned.
##' @examples
##' \dontrun{
##'   packageHtml(file = "drat_0.1.0.tar.gz",
##'               repodir = "drat", 
##'               repo.url = "https://eddelbuettel.github.io/drat",
##'               manual = TRUE)
##' }
##' @author Jan Gorecki
packageHtml = function(file = list.files(pattern = "*\\.tar\\.gz$"), repodir = ".", repo.url = character(), repo.cran = FALSE, manual = FALSE){
    
    # input check
    stopifnot(is.character(file), length(file)==1L, is.character(repodir), length(repodir)==1L)
    if (!file.exists(file)) stop("File ", file, " not found\n", call.=FALSE)
    if (!file.exists(repodir)) stop("Directory ", repodir, " not found\n", call.=FALSE)
    stopifnot(is.character(repo.url), is.logical(repo.cran) | is.character(repo.cran), is.logical(manual))
    
    # extract package name
    pkg = basename(file)
    pkgname = gsub("\\.tar\\..*$", "", pkg)
    pkgname = strsplit(pkgname, "_", fixed=TRUE)[[1L]][1L]
    pkgtype = identifyPackageType(file)
    
    # install to temp
    tmp.lib = tempdir()
    tmp.repo = file.path(tmp.lib, pkgname)
    if(file.exists(tmp.repo)) unlink(tmp.repo, recursive = TRUE)
    on.exit(try(remove.packages(pkgname, lib = tmp.lib), silent=TRUE))
    r = tryCatch(
        utils::install.packages(file, lib = tmp.lib, type = pkgtype, repos = NULL, quiet = TRUE, INSTALL_opts = if(manual) c("--html")), # `utils::` to avoid RStudio issue
        error = function(e) e,
        warning = function(w) w
    )
    # stop on warning too
    if(inherits(r, "error") || inherits(r, "warning")) stop(sprintf("Installation of %s into temporary lib.loc '%s' failed with %s: %s.", pkgname, tmp.lib, if(inherits(r, "error")) "error" else "warning", as.character(r$message)), call. = FALSE)
    
    # extract package metadata
    pkgdesc = system.file("DESCRIPTION", package = pkgname, lib.loc = tmp.lib)
    dcf = read.dcf(pkgdesc)
    stopifnot(unname(dcf[,"Package"])==pkgname)
    pkgtitle = if("Title" %in% colnames(dcf)) unname(dcf[,"Title"])
    pkgversion = if("Version" %in% colnames(dcf)) unname(dcf[,"Version"])
    upstream = if("URL" %in% colnames(dcf)) unname(dcf[,"URL"])
    additional.repo.url = if("Additional_repositories" %in% colnames(dcf)) strsplit(unname(dcf[,"Additional_repositories"]), split = ",", fixed = TRUE)[[1L]]
    
    # Additional_repositories are included into install string
    repo.url = c(repo.url, additional.repo.url)
    
    # cran can be logical for rstudio mirror or exact character address
    if(is.logical(repo.cran) && isTRUE(repo.cran)) repo.url = c(repo.url, "https://cran.rstudio.com")
    if(is.character(repo.cran) && length(repo.cran)) repo.url = c(repo.url, repo.cran)
    
    # copy manual
    if(manual){
        pkghtml = system.file("html", package = pkgname, lib.loc = tmp.lib)
        repohtml = file.path(repodir, "html")
        if(file.exists(repohtml)) unlink(repohtml, recursive = TRUE)
        dir.create(repohtml, recursive = TRUE)
        # copy DESCRIPTION which is linked from manuals
        file.copy(pkgdesc, repodir, overwrite = TRUE)
        # copy html manuals
        sapply(list.files(pkghtml, full.names = TRUE), file.copy, to = repohtml, recursive = TRUE)
    }
    
    # try get git ref info from gitlab-ci env vars
    gitrefname = Sys.getenv("CI_BUILD_REF_NAME", unset = NA)
    gitref = Sys.getenv("CI_BUILD_REF", unset = NA)
    # try travis-ci git ref info if above not available
    if(is.na(gitrefname)) gitrefname = Sys.getenv("TRAVIS_BRANCH", unset = NA)
    if(is.na(gitref)) gitref = Sys.getenv("TRAVIS_COMMIT", unset = NA)
    # if none then make 0 length chars
    gitrefname = na.omit(gitrefname)
    gitref = na.omit(gitref)
    
    # build html file
    html = c(
        "<!DOCTYPE html>",
        "<html>",
        sprintf("<head><title>%s</title></head>", pkgname),
        "<body>",
        sprintf("<h3>%s</h3>", pkgname),
        sprintf("<h4>%s</h4>", pkgtitle),
        if(length(pkgversion)) sprintf("<p>Package version: %s</p>", pkgversion),
        if(length(gitrefname) | length(gitref)){
            ch = character()
            if(length(gitrefname)) ch = sprintf("Git branch: %s", gitrefname)
            if(length(gitref)) ch = c(ch, sprintf("Git commit: %s", gitref))
            sprintf("<p>%s</p>", paste(ch, collapse = "<br/>"))
        },
        if(length(upstream)) sprintf('<p><a href="%s">upstream repo</a></p>', upstream),
        if(manual) '<p><a href="html/00Index.html">manual</a></p>',
        if(length(repo.url)) c(
            "<p>Install from R:</p>",
            sprintf('<pre><code>install.packages("%s", repos = %s)</code></pre>', pkgname, paste(deparse(repo.url, width.cutoff = 500), collapse=""))
        ),
        "<br/>",
        sprintf("<p><small>generated at %s</small></p>", as.character(Sys.time())),
        "</body>",
        "</html>"
    )
    
    # write index.html
    html.path = file.path(repodir, "index.html")
    writeLines(html, html.path)

    TRUE
}
