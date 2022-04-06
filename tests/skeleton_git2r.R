
testSkeletonGit2r <- function(wd) {
  # options(error=traceback)

  # make a package to test with
  .foofn <- function() "foo"
  utils::package.skeleton(name = "foo", list=".foofn", environment = environment(), path=wd)
  print(dir(wd, recursive = TRUE))

  message("building")

  #https://github.com/r-lib/testthat/issues/129
  R_TESTS=Sys.getenv("R_TESTS")
  Sys.setenv(R_TESTS="")
  cwd <- getwd()
  setwd(wd)
  cmd <- sprintf("%s/bin%s/R CMD build foo --no-manual",
                 Sys.getenv("R_HOME"), Sys.getenv("R_ARCH_BIN"))
  system(cmd)
  setwd(cwd)
  Sys.setenv(R_TESTS=R_TESTS)
  message("dratting")

  # make a repo to test with
  rdir <- file.path(wd, "drat")
  cat("<!doctype html><title>empty</title>", file=file.path(wd, "index.html"))

  dir.create(rdir)
  repo <- git2r::init(rdir)
  git2r::config(repo, user.name="Alice", user.email="alice@example.org")
  cat("foo", file=file.path(rdir, "README"))
  cat("<!doctype html><title>empty</title>", file=file.path(rdir, "index.html"))
  git2r::add(repo, "README")
  git2r::add(repo, "index.html")
  comm <- git2r::commit(repo, "init")

  location <- getOption("dratBranch", "gh-pages")

  if (location == "gh-pages")  {
      git2r::branch_create(comm,"gh-pages")
  } else {
      ddir <- file.path(rdir, "docs")
      if (!dir.exists(ddir)) dir.create(ddir)
  }

  # finally add the package
  drat::insertPackage(file = file.path(wd, "foo_1.0.tar.gz"), repodir = rdir, commit = "test")
  res <- list(status = git2r::status(repo),
              dir = unique(dirname(dir(rdir, recursive = TRUE))))
  if(!all(lengths(res$status) == 0L)){
    stop("Unstaged files")
  }
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib") %in% res$dir)) stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib") %in% res$dir)) stop("Wrong dir structure")
  }
  rdir
}

testRepoActions <- function(repodir){
  if (!dir.exists(file.path(repodir, "docs"))) dir.create(file.path(repodir, "docs"))
  cat("<!doctype html><title>empty</title>", file=file.path(repodir, "docs", "index.html"))
  src_files <- list.files(system.file("extdata","src", package = "drat"),
                          pattern = "foo*",
                          full.names = TRUE)
  drat::insertPackage(file = src_files[2], repodir = repodir)
  drat::insertPackage(file = src_files[3], repodir = repodir)
  repoinfo <- drat:::getRepoInfo(repopath = repodir)
  if(nrow(repoinfo) != 3L){
    stop("Not all package files found")
  }
  #
  location <- getOption("dratBranch", "gh-pages")

  bin_files_4_0 <- list.files(system.file("extdata", "4.0", package = "drat"),
                              pattern = "foo*",
                              full.names = TRUE)
  drat::insertPackages(file = bin_files_4_0, repodir = repodir)
  res <- list(dir = unique(dirname(dir(repodir, recursive = TRUE))))
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib","bin/macosx/contrib/4.0","bin/windows/contrib/4.0") %in% res$dir))
          stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib","docs/bin/macosx/contrib/4.0","docs/bin/windows/contrib/4.0") %in% res$dir))
          stop("Wrong dir structure")
  }
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = "4.0")
  if(nrow(repoinfo) != 9L){
    stop("Wrong package files found")
  }
  if(sum(repoinfo$newest) != 3L){
    stop("Package 'newest' status wrong")
  }
  #
  bin_files_3_6 <- list.files(system.file("extdata", "3.6", package = "drat"),
                              pattern = "foo*",
                              full.names = TRUE)
  drat::insertPackages(file = bin_files_3_6, repodir = repodir)
  res <- list(dir = unique(dirname(dir(repodir, recursive = TRUE))))
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib","bin/macosx/contrib/4.0","bin/windows/contrib/4.0",
                 "bin/macosx/el-capitan/contrib/3.6") %in% res$dir))
          stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib","docs/bin/macosx/contrib/4.0","docs/bin/windows/contrib/4.0",
                 "docs/bin/macosx/el-capitan/contrib/3.6") %in% res$dir))
          stop("Wrong dir structure")
  }
  #
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = "3.6")
  repoinfo2 <- drat::pruneRepo(repopath = repodir, version = "3.6")
  if(!all(repoinfo == repoinfo2)){
    stop("test run of pruneRepo changed files")
  }
  repoinfo <- drat::pruneRepo(repopath = repodir, remove = TRUE, version = "4.0")
  if(nrow(repoinfo) != 3L){
    stop("Wrong package files found after pruning")
  }
  #
  repoinfo <- drat::pruneRepo(repopath = repodir, remove = TRUE)
  #
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = NA,
                                 type = c("source","binary"))
  if(getRversion() < package_version("4.0")){
    if(nrow(repoinfo) != 4L){
      stop("Wrong package files found after pruning for version = NA")
    }
  } else {
    if(nrow(repoinfo) != 6L){
      stop("Wrong package files found after pruning for version = NA")
    }
  }
  repoinfo2 <- drat::pruneRepoForAllRversions(repopath = repodir, remove = TRUE)
  if(nrow(repoinfo2) != 4L){
    stop("Wrong package files found after pruning vor all r versions")
  }
  #
  drat::insertPackages(file = src_files, repodir = repodir)
  drat::insertPackages(file = bin_files_3_6, repodir = repodir)
  drat::insertPackages(file = bin_files_4_0, repodir = repodir)
  #
  drat::archivePackages(repopath = repodir, type = "source")
  res <- list(dir = unique(dirname(dir(repodir, recursive = TRUE))))
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib","bin/macosx/contrib/4.0","bin/windows/contrib/4.0",
                 "bin/macosx/el-capitan/contrib/3.6", "src/contrib/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib","docs/bin/macosx/contrib/4.0","docs/bin/windows/contrib/4.0",
                 "docs/bin/macosx/el-capitan/contrib/3.6", "docs/src/contrib/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  }
  drat::insertPackages(file = src_files[3], repodir = repodir, action="archive")
  #
  drat::archivePackages(repopath = repodir, type = "binary", version = "3.6")
  res <- list(dir = unique(dirname(dir(repodir, recursive = TRUE))))
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib","bin/macosx/contrib/4.0","bin/windows/contrib/4.0",
                 "bin/macosx/el-capitan/contrib/3.6",
                 "bin/macosx/el-capitan/contrib/3.6/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib","docs/bin/macosx/contrib/4.0","docs/bin/windows/contrib/4.0",
                 "docs/bin/macosx/el-capitan/contrib/3.6",
                 "docs/bin/macosx/el-capitan/contrib/3.6/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  }
  #
  drat::archivePackages(repopath = repodir, type = "win.binary", version = "4.0")
  res <- list(dir = unique(dirname(dir(repodir, recursive = TRUE))))
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib","bin/macosx/contrib/4.0","bin/windows/contrib/4.0",
                 "bin/macosx/el-capitan/contrib/3.6",
                 "bin/macosx/el-capitan/contrib/3.6/Archive/foo",
                 "bin/windows/contrib/4.0/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib","docs/bin/macosx/contrib/4.0","docs/bin/windows/contrib/4.0",
                 "docs/bin/macosx/el-capitan/contrib/3.6",
                 "docs/bin/macosx/el-capitan/contrib/3.6/Archive/foo",
                 "docs/bin/windows/contrib/4.0/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  }
  #
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version=NA)
  if(nrow(repoinfo) != 6L){
    stop("Wrong package files found for getRepoInfo")
  }
  drat::insertPackages(file = src_files, repodir = repodir)
  drat::insertPackages(file = bin_files_3_6, repodir = repodir)
  drat::insertPackages(file = bin_files_4_0, repodir = repodir)
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = "4.0")
  if(nrow(repoinfo) != 10L){
    stop("Wrong package files found for getRepoInfo after fill up")
  }
  #
  drat::archivePackages(repopath = repodir, version = "4.0")
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = "4.0")
  if(nrow(repoinfo) != 3L){
    stop("Wrong package files found for getRepoInfo after archiving")
  }
  res <- list(dir = unique(dirname(dir(repodir, recursive = TRUE))))
  if (location == "gh-pages") {
      if (!all(c(".","src/contrib","bin/macosx/contrib/4.0","bin/windows/contrib/4.0",
                 "bin/macosx/el-capitan/contrib/3.6",
                 "bin/macosx/el-capitan/contrib/3.6/Archive/foo",
                 "bin/windows/contrib/4.0/Archive/foo",
                 "src/contrib/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  } else {
      if (!all(c(".","docs/src/contrib","docs/bin/macosx/contrib/4.0","docs/bin/windows/contrib/4.0",
                 "docs/bin/macosx/el-capitan/contrib/3.6",
                 "docs/bin/macosx/el-capitan/contrib/3.6/Archive/foo",
                 "docs/bin/windows/contrib/4.0/Archive/foo",
                 "docs/src/contrib/Archive/foo") %in% res$dir))
          stop("Wrong dir structure")
  }
  #
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = NA)
  if(nrow(repoinfo) != 6L){
    stop("Wrong package files found for getRepoInfo with version = NA")
  }
  drat::archivePackagesForAllRversions(repopath = repodir)
  repoinfo <- drat:::getRepoInfo(repopath = repodir, version = NA)
  if(nrow(repoinfo) != 4L){
    stop("Wrong package files found for getRepoInfo after archiving for all R versions")
  }
  # test insertPackage optional arguments
  drat::insertPackages(file = src_files, repodir = repodir, latestOnly = TRUE)
  pkgsrds <- ifelse(location == "gh-pages", "src/contrib/PACKAGES.rds", "docs/src/contrib/PACKAGES.rds")
  PACKAGES <- readRDS(file.path(repodir, pkgsrds))
  if(nrow(PACKAGES) != 1L){
    stop("Wrong number of packages written to 'PACKAGES': ", nrow(PACKAGES), " != 1L (A)")
  }
  drat::insertPackages(file = src_files, repodir = repodir)
  PACKAGES <- readRDS(file.path(repodir, pkgsrds))
  if (nrow(PACKAGES) != 4L){
    stop("Wrong number of packages written to 'PACKAGES': ", nrow(PACKAGES), " != 4L (B)")
  }

  repodir2 <- file.path(repodir, if (location == "gh-pages") "" else "docs")
  # test updateRepo optional arguments -- now seems to update only one ?
  drat::insertPackages(file = src_files, repodir = repodir, latestOnly = TRUE)
  drat::updateRepo(repopath = repodir2)
  PACKAGES <- readRDS(file.path(repodir, pkgsrds))
  if (nrow(PACKAGES) != 4L){
    stop("Wrong number of packages updated to 'PACKAGES': ", nrow(PACKAGES), " != 4L (C)")
  }

  drat::insertPackages(file = src_files, repodir = repodir, latestOnly = TRUE)
  drat::updateRepo(repopath = repodir, latestOnly = TRUE)
  PACKAGES <- readRDS(file.path(repodir, pkgsrds))
  if (nrow(PACKAGES) != 1L){
    stop("Wrong number of packages updated to 'PACKAGES': ", nrow(PACKAGES), " != 3L (D)")
  }

  drat::insertPackages(file = src_files, repodir = repodir)
  drat::updateRepo(repopath = repodir, latestOnly = TRUE)
  PACKAGES <- readRDS(file.path(repodir, pkgsrds))
  if (nrow(PACKAGES) != 4L){
    stop("Wrong number of packages updated to 'PACKAGES': ", nrow(PACKAGES), " != 4L (E)")
  }

  file.path(repodir2, "src", "contrib", "foo_1.0.tar.gz")
  file.remove(file.path(repodir2, "src", "contrib", "foo_1.0.tar.gz"))
  drat::updateRepo(repopath = repodir2, latestOnly = TRUE)
  PACKAGES <- readRDS(file.path(repodir, pkgsrds))
  if(nrow(PACKAGES) != 3L){
    stop("Wrong number of packages updated to 'PACKAGES':", nrow(PACKAGES), "!= 3L (F)")
  }
}

runTest <- function(wd, location = "gh-pages"){
  options("dratBranch" = location)
  repodir <- testSkeletonGit2r(wd)
  testRepoActions(repodir)
  unlink(file.path(wd,"foo"), recursive = TRUE)
  unlink(file.path(wd,"drat"), recursive = TRUE)
}

wd <- tempdir()
if (requireNamespace("git2r", quietly=TRUE)) {
  runTest(wd, "gh-pages")
}
runTest(wd, "docs")
