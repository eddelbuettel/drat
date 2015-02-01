
testAdd <- function() {
    ## simple examples of how to add drat information to your session
    drat::addRepo("CRAN", "http://cran.rstudio.com")
    drat::addRepo(c("eddelbuettel", "RcppCore"))
    
    print(options("repos"))
}

testInsertLocal <- function() {
    ## simple test for local (non-GitHub) test

    ## that is my localhost setup on Ubuntu
    localRepo <- "/var/www/html/drat"
    ## guessing a tarball
    localSource <- file.path(getwd(), "..", "..",
                             paste0("drat_", packageVersion("drat"), ".tar.gz"))
    ## could be generalized via 
    if (file.exists(localRepo) && file.exists(localSource)) {
        drat::insertPackage(localSource, localRepo)
    }
}

testInsertGit <- function() {
    ## simple test for local git (non-GitHub push) test

    ## local gh-pages git dir
    localGit <- "~/git/drat"
    localGitSD <- "~/git/drat/src/contrib"
    ## guessing a tarball
    localSource <- file.path(getwd(), "..", "..",
                             paste0("drat_", packageVersion("drat"), ".tar.gz"))
    ## could be generalized via 
    if (file.exists(localSource) && file.exists(localGitSD)) {
        drat::insertPackage(localSource, localGit)
    }
}

testAdd()
testInsertLocal()
testInsertGit()
