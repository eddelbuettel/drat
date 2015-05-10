
## still raw but mostly complete ...

pruneRepo <- function(repopath=getOption("dratRepo", "~/git/drat"),
                      type="source", 
                      remove=FALSE) {

    ## TODO need to deal with binary repos...
    repodir <- file.path(repopath, "src", "contrib"),
    
    ##ext <- "_.*\\.tar\\..*$"            # with a nod to src/library/tools/packages.R
    ext <- "\\.tar\\..*$"            
    files <- list.files(repodir, pattern=ext, full.names=FALSE)

    ## subst. out the extension
    noextfiles <- gsub(ext, "", files)

    ## package names to the left
    pkgs <- sapply(strsplit(files, "_", fixed=TRUE), "[", 1L)

    ## versions is then the remainder to the right -- FIXME for something better
    verstxt <- gsub("[a-zA-Z0-9]*_", "", noextfiles)

    ## parse into proper version objects -- thanks, base R!
    vers <- package_version(verstxt)

    df <- data.frame(file=files, package=pkgs, version=vers, stringsAsFactors=FALSE)

    df <- df[order(df$package, df$version, decreasing=TRUE),]
    df$newest <- !duplicated(df$package)

    df <- df[order(df$package, df$version, decreasing=FALSE),]

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

    if (remove != FALSE) {
        rmfiles <- df[!df[,"newest"], "file"]
        if (remove == "git") {
            repo <- repository(repopath)
            for (f in rmfile) {
                fullfile <- file.path(repodir, f)
                rm_file(repo, fullfile)
            }
        } else {
            for (f in rmfile) {
                fullfile <- file.path(repodir, f)
                unlink(fullfile)
            }
        }
    }

    invisible(df)
}


