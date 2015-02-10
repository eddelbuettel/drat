
## incomplete ...

.pruneRepo <- function(repodir=getOption("dratRepo", "~/git/drat"),
                       remove=FALSE) {
    ## TODO: other extension
    ext <- ".tar.gz$"
    files <- list.files(repodir, pattern=ext, full.names=FALSE)
    noextfiles <- gsub(ext, "", files)
    ## package names to the left
    pkgs <- sapply(strsplit(files, "_", fixed=TRUE), "[", 1L)
    ## versions to the right -- FIXME
    vers <- gsub("[a-zA-Z0-9]*_", "", noextfiles)
    ## TODO: sort by version number
    
}


