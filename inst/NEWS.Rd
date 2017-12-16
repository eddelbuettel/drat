\name{NEWS}
\title{News for Package \pkg{drat}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/drat/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/drat/issues/#1}{##1}}

\section{Changes in drat version 0.1.4 (2017-12-16)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item Binaries for macOS are now split by R version into two
      different directories (Neal Futz in \ghpr{67} addring \ghit{64}).
      \item The target branch can now be set via a global option (Neal
      Futz in \ghpr{68} addressing \ghit{61}).
      \item In commit mode, add file \code{PACKAGES.rds} unconditionally.
    }
    \item Changes in drat documentation
    \itemize{
      \item Updated `README.md` removing another stale example URL
    }
  }
}

\section{Changes in drat version 0.1.3 (2017-09-16)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item Ensure `PACKAGES.rds`, if present, is also inserted in repo
      \item Use https to fetch Travis CI script from r-travis
    }
    \item Changes in drat documentation
    \itemize{
      \item Updated `README.md` removing stale example URLs (\ghpr{63})
    }
  }
}

\section{Changes in drat version 0.1.2 (2016-10-28)}{
  \itemize{
    \item Changes in drat documentation
    \itemize{
      \item The FAQ vignette added a new question \emph{Why use drat}
      \item URLs were made canonical, omegahat.net was updated from .org
      \item Several files (README.md, Description, help pages) were edited
    }
  }
}

\section{Changes in drat version 0.1.1 (2016-08-07)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item Use \code{dir.exists}, leading to versioned Depends on R (>=
      3.2.0)
      \item Optionally pull remote before insert (Mark in PR \ghpr{38})
      \item Fix support for dots (Jan G. in PR \ghpr{40})
      \item Accept dots in package names (Antonio in PR \ghpr{48})
      \item Switch to htpps URLs at GitHub (Colin in PR \ghpr{50})
      \item Support additional fields in PACKAGE file (Jan G. in PR \ghpr{54})
    }
    \item Changes in drat documentation
    \itemize{
      \item Further improvements and clarifications to vignettes
      \item Travis script switched to \code{run.sh} from our fork
      \item This NEWS file was (belatedly) added
    }
  }
}

\section{Changes in drat version 0.1.0 (2015-08-08)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item New function to optionally archive packages when inserting
      \item Improved OS X support
    }
    \item Changes in drat documentation
    \itemize{
      \item Added note about miniCRAN to FAQ vignette
      \item DESCRIPTION now credits all contributors
      \item Updated / expanded vignettes
    }
  }
}

\section{Changes in drat version 0.0.4 (2015-05-26)}{
  \itemize{
    \item Corrections to vignettes
    \item Added Windows and OS X support (Jan Schulz in PR \ghpr{16})
    \item New vignette \emph{Drat FAQ} started
    \item More improvement to code and behaviour
  }  
}

\section{Changes in drat version 0.0.3 (2015-04-10)}{
  \itemize{
    \item Small extensions and corrections to existing functionality
    \item New helper script \code{git2targz.sh}
    \item Improved documentation
    \item New vignette by Steven Pav on \emph{Why Drat?}
    \item New vignette by Colin Gilespie on \emph{Drat and Travis} 
    \item New vignettes for package authors, and users
  }
}

\section{Changes in drat version 0.0.2 (2015-03-01)}{
  \itemize{
    \item Added (optional) \pkg{git2r} support
    \item New \code{pruneRepo()} functionality
  }
}

\section{Changes in drat version 0.0.1 (2015-02-04)}{
  \itemize{
    \item Initial version with \code{insert()}, \code{add()} and more
  }
}