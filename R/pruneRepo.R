
## still incomplete ...

.pruneRepo <- function(repodir=file.path(getOption("dratRepo", "~/git/drat"), "src", "contrib"),
                       remove=FALSE) {

    ext <- "_.*\\.tar\\..*$"            # with a nod to src/library/tools/packages.R
    files <- list.files(repodir, pattern=ext, full.names=FALSE)

    ## subst. out the extension
    noextfiles <- gsub(ext, "", files)

    ## package names to the left
    pkgs <- sapply(strsplit(files, "_", fixed=TRUE), "[", 1L)

    ## versions is then the remainder to the right -- FIXME for something better
    verstxt <- gsub("[a-zA-Z0-9]*_", "", noextfiles)

    ## parse into proper version objects -- thanks, base R!
    vers <- package_version(verstxt)

    df <- data.frame(file=files, package=pkgs, version=vers)

    df <- df[order(df$package, df$version, decreasing=TRUE),]
    df$newest <- !duplicated(df$package)

    df <- df[order(df$package, df$version, decreasing=FALSE),]

}


