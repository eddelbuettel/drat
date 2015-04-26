\name{drat-package}
\alias{drat-package}
\alias{drat}
\docType{package}
\title{
  Easy-to-use package repository creation and access
}
\description{
  The drat package permits user to create and use ad-hoc package
  repositories. It takes advantage of GitHub accounts and
  \sQuote{gh-pages} branches which automatically become web-accessible
  and can be used to provide a repository.  Alternatively, custom
  repository paths and addresses can be used.
  
}
\details{
  Given a user account on GitHub, say, \sQuote{eddelbuettel}, and a repository
  \sQuote{drat}, we can infer an top-level repostory URL as such as
  \url{http://eddelbuettel.github.io/drat} by supplying only the username (as
  the rest is inferred by defaults).  This allows us to create easily
  useable, identifiable and shareable per-user repositories---without
  the user having to create and administer a webserver anywhere.

  Two higher level functions then allow both insertion of (source or
  binary) packages, as well as addition of a given drat repository to an
  R session so that package in the repository can be accesses.
}
\author{
Dirk Eddelbuettel

Maintainer: Dirk Eddelbuettel <edd@debian.org>
}
\references{
  The R Installation and Administration manual has more and details about
  repository creation
}
% Optionally other standard keywords, one per line,
% from the file KEYWORDS in the R documentation.
\keyword{ package }
\seealso{
  \code{\link[utils]{update.packages}},
  \code{\link[utils]{available.packages}},
  \code{\link[utils]{install.packages}}
}
\examples{
  \dontrun{
  drat::addRepo("eddelbuettel")   # adds the repo of GitHub user 'eddelbuettel'
}
}
