
isIntelMac <- .Platform$pkgType == "mac.binary.big-sur-x86_64"
isRVersion4.3 <- getRversion() >= "4.3.0" && getRversion() < "4.4.0"
options("dratBranch" = "docs")

repodir <- tempdir()
docsdir <- file.path(repodir, "docs")
if (!dir.exists(docsdir)) dir.create(docsdir)
cat("<!doctype html><title>empty</title>", file=file.path(docsdir, "index.html"))

isWindows <- Sys.info()[["sysname"]] == "Windows"

if (!isWindows) {                             # this is the default case of a source package
    pkg <- system.file("extdata", "src", "bar_1.1.tar.gz", package="drat")
    drat::insertPackage(file = pkg, repodir = repodir)
    
    avpkg <- available.packages(repos=file.path("file:", docsdir))
    
    good <- avpkg[1,1] == "bar" && avpkg[1,2] == "1.1"
    if (!good) stop("Package round-turn failed for big-sur-x86_64 source package")
}



if (isIntelMac && isRVersion4.3) {
    pkg <- system.file("extdata", "big-sur-x86_64", "bin", "4.3", "bar_1.1.tgz", package="drat")
    drat::insertPackage(file = pkg, repodir = repodir, action = "prune")
    avpkg <- available.packages(repos=file.path("file:", docsdir))
    
    good <- avpkg[1,1] == "bar" && avpkg[1,2] == "1.1"
    if (!good) stop("Package round-turn failed for big-sur-x86_64 binary package")
}
