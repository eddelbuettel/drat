
## simple examples of how to add drat information to your session
drat::addRepo("CRAN", "http://cran.rstudio.com")
drat::addRepo(c("eddelbuettel", "RcppCore"))

print(options("repos"))
