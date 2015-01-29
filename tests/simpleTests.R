
## simple examples of how to add drat information to your session
drat::add("CRAN", "http://cran.rstudio.com")
drat::add(c("eddelbuettel", "RcppCore"))

print(options("repos"))
