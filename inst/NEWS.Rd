\name{NEWS}
\title{News for Package \pkg{drat}}
\newcommand{\ghpr}{\href{https://github.com/eddelbuettel/drat/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/eddelbuettel/drat/issues/#1}{##1}}

\section{Changes in drat version 0.2.1 (2021-07-09)}{
  \itemize{
    \item Two internal functions now have a note in their documentation
    stating them as not exported (Dirk in response to \ghit{123})
    \item Repositories created by \code{initRepo} now have an placeholder
    \code{index.html} to not trigger a \code{curl} check at CRAN (Dirk)
    \item Adding to a repository now checks for a top-level
    \code{index.html} and displays a message if missing (Dirk)
    \item The DratStepByStep.Rmd vignette mentions the added
    \code{index.html} file
  }
}

\section{Changes in drat version 0.2.0 (2021-04-21)}{
  \itemize{
    \item A documentation website for the package was added at
    \url{https://eddelbuettel.github.io/drat/} (Dirk)
    \item The continuous integration was switched to using \sQuote{r-ci}
    (Dirk) 
    \item The \code{docs/} directory of the main repository branch can
    now be used instead of \code{gh-pages} branch (Dirk in \ghpr{112})
    \item A new repository \url{https://github.com/drat-base/drat} can
    now be used to fork an initial \code{drat} repository (Dirk)
    \item A new vignette \dQuote{Drat Step-by-Step} was added (Roman
    Hornung and Dirk in \ghpr{117} fixing \ghit{115} and \ghit{113})
    \item The test suite was refactored for \code{docs/} use (Felix
    Ernst in \ghpr{118})
    \item The minimum R version is now \sQuote{R (>= 3.6)} (Dirk fixing
    \ghit{119}) 
    \item The vignettes were switched to \code{minidown} (Dirk fixing
    \ghit{116})
    \item A new test file was added to ensure \sQuote{NEWS.Rd} is always
    at the current release version.
  }
}

\section{Changes in drat version 0.1.8 (2020-07-18)}{
  \itemize{
    \item The archive pruning test code was corrected for r-oldrel
    (Felix Ernst in \ghpr{105} fixing \ghit{104}).
  }
}

\section{Changes in drat version 0.1.7 (2020-07-10)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item Functions \code{insertPackages}, \code{archivePackages} and
      \code{prunePackages} are now vectorised (Patrick Schratz and Felix
      Ernst in \ghpr{93}, \ghpr{100}).
      \item The new functionality is supported by unit tests (Felix
      Ernst in \ghpr{93}, and \ghpr{102} fixing \ghit{101}).
      \item Added new function \code{updateRepo} (Felix
      Ernst in \ghpr{95}, \ghpr{97}).
    }
  }
}

\section{Changes in drat version 0.1.6 (2020-05-29)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item Support for the various (current) macOS binary formats was
      rewritten (Felix Ernst in \ghpr{89} fixing \ghit{88}).
      \item Travis CI use was updated to R 4.0.0 and bionic (Dirk).
      \item A drat repo was added to the README (Thomas Fuller in \ghpr{86})
    }
  }
}
    
\section{Changes in drat version 0.1.5 (2019-03-28)}{
  \itemize{
    \item Changes in drat functionality
    \itemize{
      \item Windows paths are handled better when inserting packages
      (Neal Fultz in \ghpr{70})
      \item Binary packages are now supported for the \code{pruneRepo}
      and \code{archivePackages} commands (Christoph Stepper in \ghpr{79}).
    }
    \item Changes in drat documentation
    \itemize{
      \item Properly prefix R path in \code{system} call in a tests
      (Dirk in minor cleanup to \ghpr{70}).
    }
  }
}

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
