
##' The function determines which packages in a repositories can be
##' removed as they are being \sQuote{shadowed} by a newer version of
##' the same packages.
##'
##' Given a package name, R will always find the newest version of
##' that package. Older versions are therefore effectively shadowed
##' and can be removed without functionally changing a repository.
##' 
##' However, if a current package file is removed without \code{pruneRepo}, the
##' PACKAGES, PACKAGES.gz and PACKAGES.rds file might be not up to date. To 
##' ensure the correct information is available in these indices, run 
##' \code{updateRepo}.
##'
##' These functions are still undergoing development and polish and may
##' change in subsequent versions.
##' 
##' @name pruneRepo
##' @title Prune repository from older copies of packages
##' @param repopath Character variable with the path to the repo;
##'  defaults to the value of the \dQuote{dratRepo} option with
##'  \dQuote{"~/git/drat"} as fallback
##' @param type Character variable for the type of repository, so far
##'  \dQuote{source}, \dQuote{binary}, \dQuote{win.binary}, \dQuote{mac.binary}, 
##'  \dQuote{mac.binary.mavericks}, \dQuote{mac.binary.el-capitan} or 
##'  \dQuote{both}
##' @param pkg Optional character variable specifying a package name,
##'  whose older versions should be pruned. If missing (the
##'  default), pruning is performed on all packages.
##' @param version R version information in the format \code{X.Y} or 
##'   \code{X.Y.Z}. Only used, if pruning binary packages. 
##'   (default: \code{version = getRversion()}). If \code{version = NA}, all
##'   available R versions will be used. If \code{version = NULL}, this defaults
##'   to \code{getRversion()}.
##' @param location An optional character variable with the GitHub Pages location:
##'   either \dQuote{gh-pages} indicating a branch of that name, or
##'   \dQuote{docs/} directory in the main branch. The default value can
##'   be overridden via the \dQuote{dratBranch} option.
##' @param remove Character or logical variable indicating whether
##'  files should be removed. Nothing happens if \sQuote{FALSE}. If
##'  different from (logical) \sQuote{FALSE} and equal to character
##'  \dQuote{git} files are removed via \code{git rm} else via a
##'  straight file deletion.
##' @param ... For \code{updateRepo} a catch-all collection of parameters. 
##'   Arguments passed to \code{update_PACKAGES} currently include 
##'   \code{latestOnly}, for which the default value is set here to \code{FALSE}. 
##'   See \code{\link{update_PACKAGES}}. Please note that this has an effect 
##'   for \code{update_PACKAGES} only, if new packages are found, e.g. manually  
##'   added. 
##' @return A data frame describing the repository is returned
##'  containing columns with columns \dQuote{file},
##'  \dQuote{package} (just the name), \dQuote{version} and a
##'  logical variable \dQuote{newest} indicating if the package can
##'  be removed.
##' @author Dirk Eddelbuettel
getRepoInfo <- function(repopath = getOption("dratRepo", "~/git/drat"),
                        type = c("source", "binary", "mac.binary", "mac.binary.el-capitan",
                                 "mac.binary.mavericks", "win.binary", "both"), 
                        pkg,
                        version = getRversion(),
                        location = getOption("dratBranch", "gh-pages")
                        ) {
    ## input check
    .check_location_arg(location)
    if (location == "docs" && !grepl("docs$", repopath)) repopath <- file.path(repopath, location)
    .check_path(repopath)
    type <- .norm_type(type)
    pkg <- .norm_pkg(pkg)
    ## knows how to handle binary repos
    repodir <- contrib.url2(repopath, type, version)
    # this also checks for valid types
    types <- type[match(names(repodir),type)]
    ext <- lapply(types,.get_file_extension_from_package_type)
    # assemble repo info per package type
    infos <- mapply(.get_repoinfo_per_package_type, types, ext, repodir,
                    MoreArgs = list(pkg = pkg),
                    SIMPLIFY = FALSE)
    # remove empty results and rbind
    infos <- infos[vapply(vapply(infos,nrow,integer(1)),">",logical(1),0L)]
    infos <- do.call(rbind,unname(infos))
    rownames(infos) <- NULL # reset rownames
    invisible(infos)
}

.get_file_extension_from_package_type <- function(type){
    ##ext <- "_.*\\.tar\\..*$"            # with a nod to src/library/tools/packages.R
    # ext <- "\\.tar\\..*$"            
    
    ## type == "both" is not supported
    ext <- if (type == "source") {
        "\\.tar\\..*$"
    } else if (grepl("mac.binary",type)) {
        "\\.tgz$"
    } else if (type == "win.binary") {
        "\\.zip$"
    } else {
        stop("Unknown package type", call. = FALSE)
    }
    ext
}

.get_repoinfo_per_package_type <- function(t, e, rd, pkg){
    files <- list.files(rd, pattern = e, full.names = FALSE)
    if(length(files) == 0L){
        return(data.frame())
    }
    
    R_version <- t
    if(t != "source"){
        R_version <- regmatches(rd,regexpr(DRAT_VERSION_REGEX, rd))
    }
    
    ## subst. out the extension
    noextfiles <- gsub(e, "", files)
    noextfiles <- do.call(rbind, strsplit(noextfiles, "_", fixed = TRUE))
    
    ## package names to the left
    # pkgs <- sapply(strsplit(files, "_", fixed=TRUE), "[", 1L)
    pkgs <- noextfiles[, 1L]
    
    ## versions is then the remainder to the right -- FIXME for something better
    # verstxt <- gsub("[a-zA-Z0-9\\.]*_", "", noextfiles)
    verstxt <- noextfiles[, 2L]
    
    
    ## parse into proper version objects -- thanks, base R!
    vers <- package_version(verstxt)
    
    df <- data.frame(file = files, package = pkgs, version = vers, 
                     type = t, contrib.url = rd,
                     stringsAsFactors = FALSE)
    
    df <- df[order(df$package, df$version, decreasing = TRUE),]
    df$newest <- !duplicated(df$package)
    
    df <- df[order(df$package, df$version, decreasing = FALSE),]
    if (!is.null(pkg)) {
        df <- df[df$package %in% pkg,]
    }
    
    ## example output below plus additional type column
    ## R> df
    ##                      file   package  version newest
    ## 1     drat_0.0.3.1.tar.gz      drat  0.0.3.1   TRUE
    ## 2   fasttime_1.0-1.tar.gz  fasttime    1.0.1   TRUE
    ## 6  Rblpapi_0.2.1.9.tar.gz   Rblpapi  0.2.1.9  FALSE
    ## 3 Rblpapi_0.2.1.11.tar.gz   Rblpapi 0.2.1.11  FALSE
    ## 4 Rblpapi_0.2.1.12.tar.gz   Rblpapi 0.2.1.12  FALSE
    ## 5 Rblpapi_0.2.1.14.tar.gz   Rblpapi 0.2.1.14   TRUE
    ## 7   RcppR6_0.2.001.tar.gz    RcppR6    0.2.1   TRUE
    ## 8   RcppTOML_0.0.3.tar.gz  RcppTOML    0.0.3   TRUE
    ## 9  winsorize_0.0.2.tar.gz winsorize    0.0.2   TRUE
    ## R>
    df
}

##' @rdname pruneRepo
pruneRepo <- function(repopath = getOption("dratRepo", "~/git/drat"),
                      type = c("source", "mac.binary", "mac.binary.el-capitan",
                               "mac.binary.mavericks", "win.binary", "both"), 
                      pkg,
                      version = getRversion(),
                      remove = FALSE,
                      location = getOption("dratBranch", "gh-pages")) {
    ## input check
    .check_location_arg(location)
    if (location == "docs" && !grepl("docs$", repopath)) repopath <- file.path(repopath, location)
    .check_path(repopath)
    type <- .norm_type(type)
    pkg <- .norm_pkg(pkg)
    #
    repoinfo <- getRepoInfo(repopath = repopath, type = type, pkg = pkg,
                            version = version)
    rmfiles <- repoinfo[!repoinfo[,"newest"],]
    if (remove != FALSE && nrow(rmfiles) >= 1L) {
        if (remove == "git") {
            haspkg <- requireNamespace("git2r", quietly = TRUE)
            if (!haspkg)
                stop("The 'pruneRepo' function requires the 'git2r' packages.", call. = FALSE)
            git_repo <- git2r::repository(repopath)
            mapply(.prune_git, rmfiles$contrib.url, rmfiles$file,
                   MoreArgs = list(git_repo = git_repo))
        } else {
            mapply(.prune_cmd, rmfiles$contrib.url, rmfiles$file)
        }
        updateRepo(repopath, type = unique(rmfiles$type), version = version)
        repoinfo <- repoinfo[repoinfo[,"newest"],]
    }
    invisible(repoinfo)
}

.prune_git <- function(rd, f, git_repo){
    fullfile <- file.path(rd, f)
    git2r::rm_file(git_repo, fullfile)
}

.prune_cmd <- function(rd, f){
    fullfile <- file.path(rd, f)
    unlink(fullfile)
}

##' @rdname pruneRepo
pruneRepoForAllRversions <- function(repopath = getOption("dratRepo", "~/git/drat"),
                                     type = c("source", "mac.binary", "mac.binary.el-capitan",
                                              "mac.binary.mavericks", "win.binary", "both"), 
                                     pkg,
                                     remove = FALSE){
    pruneRepo(repopath = repopath, type = type, pkg = pkg, version = NA,
              remove = remove)
}

##' @rdname pruneRepo
updateRepo <- function(repopath = getOption("dratRepo", "~/git/drat"),
                       type = c("source", "mac.binary", "mac.binary.el-capitan",
                                "mac.binary.mavericks", "win.binary", "both"),
                       version = NA,
                       ... ){
    # input check
    .check_path(repopath)
    type <- .norm_type(type)
    #
    repodir <- contrib.url2(repopath, type, version)
    repodir <- repodir[dir.exists(repodir)]
    args <- .norm_tools_package_args(...)
    .update_packages_index(repodir, args)
}

.update_packages_index <- function(contrib.url, args){
    update_pkgtype <- lapply(names(contrib.url),.get_write_PACKAGES_type)
    update <- mapply(update_PACKAGES, dir = contrib.url, type = update_pkgtype,
                     MoreArgs = args)
    invisible(NULL)
}
