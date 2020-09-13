### Version 0.1.8 (2020-07-18)

-   The archive pruning test code was corrected for r-oldrel (Felix
    Ernst in [\#105](https://github.com/eddelbuettel/drat/pull/105)
    fixing [\#104](https://github.com/eddelbuettel/drat/issues/104)).

### Version 0.1.7 (2020-07-10)

-   Changes in drat functionality

    -   Functions `insertPackages`, `archivePackages` and
        `prunePackages` are now vectorised (Patrick Schratz and Felix
        Ernst in [\#93](https://github.com/eddelbuettel/drat/pull/93),
        [\#100](https://github.com/eddelbuettel/drat/pull/100)).

    -   The new functionality is supported by unit tests (Felix Ernst in
        [\#93](https://github.com/eddelbuettel/drat/pull/93), and
        [\#102](https://github.com/eddelbuettel/drat/pull/102) fixing
        [\#101](https://github.com/eddelbuettel/drat/issues/101)).

    -   Added new function `updateRepo` (Felix Ernst in
        [\#95](https://github.com/eddelbuettel/drat/pull/95),
        [\#97](https://github.com/eddelbuettel/drat/pull/97)).

### Version 0.1.6 (2020-05-29)

-   Changes in drat functionality

    -   Support for the various (current) macOS binary formats was
        rewritten (Felix Ernst in
        [\#89](https://github.com/eddelbuettel/drat/pull/89) fixing
        [\#88](https://github.com/eddelbuettel/drat/issues/88)).

    -   Travis CI use was updated to R 4.0.0 and bionic (Dirk).

    -   A drat repo was added to the README (Thomas Fuller in
        [\#86](https://github.com/eddelbuettel/drat/pull/86))

### Version 0.1.5 (2019-03-28)

-   Changes in drat functionality

    -   Windows paths are handled better when inserting packages (Neal
        Fultz in [\#70](https://github.com/eddelbuettel/drat/pull/70))

    -   Binary packages are now supported for the `pruneRepo` and
        `archivePackages` commands (Christoph Stepper in
        [\#79](https://github.com/eddelbuettel/drat/pull/79)).

-   Changes in drat documentation

    -   Properly prefix R path in `system` call in a tests (Dirk in
        minor cleanup to
        [\#70](https://github.com/eddelbuettel/drat/pull/70)).

### Version 0.1.4 (2017-12-16)

-   Changes in drat functionality

    -   Binaries for macOS are now split by R version into two different
        directories (Neal Futz in
        [\#67](https://github.com/eddelbuettel/drat/pull/67) addring
        [\#64](https://github.com/eddelbuettel/drat/issues/64)).

    -   The target branch can now be set via a global option (Neal Futz
        in [\#68](https://github.com/eddelbuettel/drat/pull/68)
        addressing
        [\#61](https://github.com/eddelbuettel/drat/issues/61)).

    -   In commit mode, add file `PACKAGES.rds` unconditionally.

-   Changes in drat documentation

    -   Updated \'README.md\' removing another stale example URL

### Version 0.1.3 (2017-09-16)

-   Changes in drat functionality

    -   Ensure \'PACKAGES.rds\', if present, is also inserted in repo

    -   Use https to fetch Travis CI script from r-travis

-   Changes in drat documentation

    -   Updated \'README.md\' removing stale example URLs
        ([\#63](https://github.com/eddelbuettel/drat/pull/63))

### Version 0.1.2 (2016-10-28)

-   Changes in drat documentation

    -   The FAQ vignette added a new question *Why use drat*

    -   URLs were made canonical, omegahat.net was updated from .org

    -   Several files (README.md, Description, help pages) were edited

### Version 0.1.1 (2016-08-07)

-   Changes in drat functionality

    -   Use `dir.exists`, leading to versioned Depends on R (\>= 3.2.0)

    -   Optionally pull remote before insert (Mark in PR
        [\#38](https://github.com/eddelbuettel/drat/pull/38))

    -   Fix support for dots (Jan G. in PR
        [\#40](https://github.com/eddelbuettel/drat/pull/40))

    -   Accept dots in package names (Antonio in PR
        [\#48](https://github.com/eddelbuettel/drat/pull/48))

    -   Switch to htpps URLs at GitHub (Colin in PR
        [\#50](https://github.com/eddelbuettel/drat/pull/50))

    -   Support additional fields in PACKAGE file (Jan G. in PR
        [\#54](https://github.com/eddelbuettel/drat/pull/54))

-   Changes in drat documentation

    -   Further improvements and clarifications to vignettes

    -   Travis script switched to `run.sh` from our fork

    -   This NEWS file was (belatedly) added

### Version 0.1.0 (2015-08-08)

-   Changes in drat functionality

    -   New function to optionally archive packages when inserting

    -   Improved OS X support

-   Changes in drat documentation

    -   Added note about miniCRAN to FAQ vignette

    -   DESCRIPTION now credits all contributors

    -   Updated / expanded vignettes

### Version 0.0.4 (2015-05-26)

-   Corrections to vignettes

-   Added Windows and OS X support (Jan Schulz in PR
    [\#16](https://github.com/eddelbuettel/drat/pull/16))

-   New vignette *Drat FAQ* started

-   More improvement to code and behaviour

### Version 0.0.3 (2015-04-10)

-   Small extensions and corrections to existing functionality

-   New helper script `git2targz.sh`

-   Improved documentation

-   New vignette by Steven Pav on *Why Drat?*

-   New vignette by Colin Gilespie on *Drat and Travis*

-   New vignettes for package authors, and users

### Version 0.0.2 (2015-03-01)

-   Added (optional) `git2r` support

-   New `pruneRepo()` functionality

### Version 0.0.1 (2015-02-04)

-   Initial version with `insert()`, `add()` and more
