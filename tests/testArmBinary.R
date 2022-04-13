
isWindows <- Sys.info()[["sysname"]] == "Windows"
isArm <- Sys.info()[["machine"]] == "arm64"
isVersion41 <- getRversion() >= "4.1.0" && getRversion() < "4.2.0"
options("dratBranch" = "docs")

repodir <- tempdir()
docsdir <- file.path(repodir, "docs")
if (!dir.exists(docsdir)) dir.create(docsdir)
cat("<!doctype html><title>empty</title>", file=file.path(docsdir, "index.html"))

if (!isWindows) {                             # this is the default case of a source package
    pkg <- system.file("extdata", "src", "bar_1.0.tar.gz", package="drat")
    drat::insertPackage(file = pkg, repodir = repodir)

    avpkg <- available.packages(repos=file.path("file:", docsdir))

    good <- avpkg[1,1] == "bar" && avpkg[1,2] == "1.0"
    if (!good) stop("Package round-turn failed for source package")
}

if (isArm && isVersion41) {
    pkg <- system.file("extdata", "big-sur-arm64", "bin", "4.1", "bar_1.0.tgz", package="drat")
    drat::insertPackage(file = pkg, repodir = repodir)

    avpkg <- available.packages(repos=file.path("file:", docsdir))

    good <- avpkg[1,1] == "bar" && avpkg[1,2] == "1.0"
    if (!good) stop("Package round-turn failed for Arm binary package")
}
