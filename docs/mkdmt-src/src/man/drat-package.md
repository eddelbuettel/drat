## Easy-to-use package repository creation and access

### Description

The drat package permits user to create and use ad-hoc package
repositories. It takes advantage of GitHub accounts and ‘gh-pages’
branches which automatically become web-accessible and can be used to
provide a repository. Alternatively, custom repository paths and
addresses can be used.

### Details

Given a user account on GitHub, say, ‘eddelbuettel’, and a repository
‘drat’, we can infer an top-level repostory URL as such as
<https://eddelbuettel.github.io/drat/> by supplying only the username
(as the rest is inferred by defaults). This allows us to create easily
useable, identifiable and shareable per-user repositories—without the
user having to create and administer a webserver anywhere.

Two higher level functions then allow both insertion of (source or
binary) packages, as well as addition of a given drat repository to an R
session so that package in the repository can be accesses.

### Author(s)

Dirk Eddelbuettel

Maintainer: Dirk Eddelbuettel &lt;edd@debian.org&gt;

### References

The R Installation and Administration manual has more and details about
repository creation

### See Also

`update.packages`, `available.packages`, `install.packages`

### Examples

      ## Not run: 
      drat::addRepo("eddelbuettel")   # adds the repo of GitHub user 'eddelbuettel'

    ## End(Not run)
