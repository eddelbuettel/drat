
testSkeletonGit2r <- function() {
  if(!requireNamespace("git2r")) return(warning("couldn't find git2r"))
  
  wd <- tempdir()
  
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
  system("R CMD build foo --no-manual")
  setwd(cwd)
  Sys.setenv(R_TESTS=R_TESTS)
  message("dratting")
  
  # make a repo to test with
  rdir <- file.path(wd, "drat")
  
  dir.create(rdir)
  repo <- git2r::init(rdir)
  git2r::config(repo, user.name="Alice", user.email="alice@example.org")
  cat("foo", file=file.path(rdir, "README"))
  git2r::add(repo, "README")
  comm <- git2r::commit(repo, "init")
  git2r::branch_create(comm,"gh-pages")

  # finally add the package
  drat::insertPackage(file = file.path(wd, "foo_1.0.tar.gz"), repodir = rdir, commit = "test")
  list(git2r::status(repo), dir(rdir, recursive = TRUE))
}

testSkeletonGit2r()
