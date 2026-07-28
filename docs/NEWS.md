

# News for Package <span class="pkg">drat</span>

## Changes in drat version 0.2.5 (2024-10-21)

<ul>
<li>

Function <code>insertPackage</code> has a new optional argument
<code>OSflavour</code> (Arne Holmin in
<a href="https://github.com/eddelbuettel/drat/pull/142">[#142](https://github.com/eddelbuettel/drat/issues/142)</a>)

</li>
<li>

A test file conditions correctly about <span class="pkg">git2r</span>
being present (Dirk)

</li>
<li>

Several smaller packaging updates and enhancements to continuous
integration and documentation have been added (Dirk)

</li>
</ul>

## Changes in drat version 0.2.4 (2023-10-09)

<ul>
<li>

macOS Arm M1 repos are now also supported in pruning and archival  
(Joey Reid in
<a href="https://github.com/eddelbuettel/drat/pull/135">[#135](https://github.com/eddelbuettel/drat/issues/135)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/134">[#134](https://github.com/eddelbuettel/drat/issues/134)</a>)

</li>
<li>

A minor vignette typo was fixed (Dirk)

</li>
<li>

A small error with <code>setwd()</code> in <code>insertPackage()</code>
was corrected (Dirk)

</li>
<li>

macOS x86_64 repos (on big-sur) are now supported too (Arne Johannes
Holmin in
<a href="https://github.com/eddelbuettel/drat/pull/139">[#139](https://github.com/eddelbuettel/drat/issues/139)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/138">[#138](https://github.com/eddelbuettel/drat/issues/138)</a>)

</li>
<li>

A few small maintenance tweaks were applied to the CI setup, and to the
main README.md

</li>
</ul>

## Changes in drat version 0.2.3 (2022-04-13)

<ul>
<li>

Arm M1 repos are now supported
(<a href="https://github.com/eddelbuettel/drat/pull/126">[#126](https://github.com/eddelbuettel/drat/issues/126)</a> and
<a href="https://github.com/eddelbuettel/drat/pull/131">[#131](https://github.com/eddelbuettel/drat/issues/131)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/125">[#125](https://github.com/eddelbuettel/drat/issues/125)</a>)

</li>
<li>

A vignette typo has been fixed
(<a href="https://github.com/eddelbuettel/drat/pull/130">[#130](https://github.com/eddelbuettel/drat/issues/130)</a>)

</li>
</ul>

## Changes in drat version 0.2.2 (2021-12-01)

<ul>
<li>

Travis artifacts and badges have been pruned

</li>
<li>

Vignettes now use <span class="pkg">simplermarkdown</span>

</li>
</ul>

## Changes in drat version 0.2.1 (2021-07-09)

<ul>
<li>

Two internal functions now have a note in their documentation stating
them as not exported (Dirk in response to
<a href="https://github.com/eddelbuettel/drat/issues/123">[#123](https://github.com/eddelbuettel/drat/issues/123)</a>)

</li>
<li>

Repositories created by <code>initRepo</code> now have an placeholder
<code>index.html</code> to not trigger a <code>curl</code> check at CRAN
(Dirk)

</li>
<li>

Adding to a repository now checks for a top-level
<code>index.html</code> and displays a message if missing (Dirk)

</li>
<li>

The DratStepByStep.Rmd vignette mentions the added
<code>index.html</code> file

</li>
</ul>

## Changes in drat version 0.2.0 (2021-04-21)

<ul>
<li>

A documentation website for the package was added at
<a href="https://eddelbuettel.github.io/drat/">https://eddelbuettel.github.io/drat/</a>
(Dirk)

</li>
<li>

The continuous integration was switched to using ‘r-ci’ (Dirk)

</li>
<li>

The <code>docs/</code> directory of the main repository branch can now
be used instead of <code>gh-pages</code> branch (Dirk in
<a href="https://github.com/eddelbuettel/drat/pull/112">[#112](https://github.com/eddelbuettel/drat/issues/112)</a>)

</li>
<li>

A new repository
<a href="https://github.com/drat-base/drat">https://github.com/drat-base/drat</a>
can now be used to fork an initial <code>drat</code> repository (Dirk)

</li>
<li>

A new vignette “Drat Step-by-Step” was added (Roman Hornung and Dirk in
<a href="https://github.com/eddelbuettel/drat/pull/117">[#117](https://github.com/eddelbuettel/drat/issues/117)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/115">[#115](https://github.com/eddelbuettel/drat/issues/115)</a> and
<a href="https://github.com/eddelbuettel/drat/issues/113">[#113](https://github.com/eddelbuettel/drat/issues/113)</a>)

</li>
<li>

The test suite was refactored for <code>docs/</code> use (Felix Ernst in
<a href="https://github.com/eddelbuettel/drat/pull/118">[#118](https://github.com/eddelbuettel/drat/issues/118)</a>)

</li>
<li>

The minimum R version is now ‘R (\>= 3.6)’ (Dirk fixing
<a href="https://github.com/eddelbuettel/drat/issues/119">[#119](https://github.com/eddelbuettel/drat/issues/119)</a>)

</li>
<li>

The vignettes were switched to <code>minidown</code> (Dirk fixing
<a href="https://github.com/eddelbuettel/drat/issues/116">[#116](https://github.com/eddelbuettel/drat/issues/116)</a>)

</li>
<li>

A new test file was added to ensure ‘NEWS.Rd’ is always at the current
release version.

</li>
</ul>

## Changes in drat version 0.1.8 (2020-07-18)

<ul>
<li>

The archive pruning test code was corrected for r-oldrel (Felix Ernst in
<a href="https://github.com/eddelbuettel/drat/pull/105">[#105](https://github.com/eddelbuettel/drat/issues/105)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/104">[#104](https://github.com/eddelbuettel/drat/issues/104)</a>).

</li>
</ul>

## Changes in drat version 0.1.7 (2020-07-10)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

Functions <code>insertPackages</code>, <code>archivePackages</code> and
<code>prunePackages</code> are now vectorised (Patrick Schratz and Felix
Ernst in <a href="https://github.com/eddelbuettel/drat/pull/93">[#93](https://github.com/eddelbuettel/drat/issues/93)</a>,
<a href="https://github.com/eddelbuettel/drat/pull/100">[#100](https://github.com/eddelbuettel/drat/issues/100)</a>).

</li>
<li>

The new functionality is supported by unit tests (Felix Ernst in
<a href="https://github.com/eddelbuettel/drat/pull/93">[#93](https://github.com/eddelbuettel/drat/issues/93)</a>, and
<a href="https://github.com/eddelbuettel/drat/pull/102">[#102](https://github.com/eddelbuettel/drat/issues/102)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/101">[#101](https://github.com/eddelbuettel/drat/issues/101)</a>).

</li>
<li>

Added new function <code>updateRepo</code> (Felix Ernst in
<a href="https://github.com/eddelbuettel/drat/pull/95">[#95](https://github.com/eddelbuettel/drat/issues/95)</a>,
<a href="https://github.com/eddelbuettel/drat/pull/97">[#97](https://github.com/eddelbuettel/drat/issues/97)</a>).

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.6 (2020-05-29)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

Support for the various (current) macOS binary formats was rewritten
(Felix Ernst in
<a href="https://github.com/eddelbuettel/drat/pull/89">[#89](https://github.com/eddelbuettel/drat/issues/89)</a> fixing
<a href="https://github.com/eddelbuettel/drat/issues/88">[#88](https://github.com/eddelbuettel/drat/issues/88)</a>).

</li>
<li>

Travis CI use was updated to R 4.0.0 and bionic (Dirk).

</li>
<li>

A drat repo was added to the README (Thomas Fuller in
<a href="https://github.com/eddelbuettel/drat/pull/86">[#86](https://github.com/eddelbuettel/drat/issues/86)</a>)

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.5 (2019-03-28)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

Windows paths are handled better when inserting packages (Neal Fultz in
<a href="https://github.com/eddelbuettel/drat/pull/70">[#70](https://github.com/eddelbuettel/drat/issues/70)</a>)

</li>
<li>

Binary packages are now supported for the <code>pruneRepo</code> and
<code>archivePackages</code> commands (Christoph Stepper in
<a href="https://github.com/eddelbuettel/drat/pull/79">[#79](https://github.com/eddelbuettel/drat/issues/79)</a>).

</li>
</ul>
</li>
<li>

Changes in drat documentation

<ul>
<li>

Properly prefix R path in <code>system</code> call in a tests (Dirk in
minor cleanup to
<a href="https://github.com/eddelbuettel/drat/pull/70">[#70](https://github.com/eddelbuettel/drat/issues/70)</a>).

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.4 (2017-12-16)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

Binaries for macOS are now split by R version into two different
directories (Neal Futz in
<a href="https://github.com/eddelbuettel/drat/pull/67">[#67](https://github.com/eddelbuettel/drat/issues/67)</a> addring
<a href="https://github.com/eddelbuettel/drat/issues/64">[#64](https://github.com/eddelbuettel/drat/issues/64)</a>).

</li>
<li>

The target branch can now be set via a global option (Neal Futz in
<a href="https://github.com/eddelbuettel/drat/pull/68">[#68](https://github.com/eddelbuettel/drat/issues/68)</a>
addressing
<a href="https://github.com/eddelbuettel/drat/issues/61">[#61](https://github.com/eddelbuettel/drat/issues/61)</a>).

</li>
<li>

In commit mode, add file <code>PACKAGES.rds</code> unconditionally.

</li>
</ul>
</li>
<li>

Changes in drat documentation

<ul>
<li>

Updated ‘README.md’ removing another stale example URL

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.3 (2017-09-16)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

Ensure ‘PACKAGES.rds’, if present, is also inserted in repo

</li>
<li>

Use https to fetch Travis CI script from r-travis

</li>
</ul>
</li>
<li>

Changes in drat documentation

<ul>
<li>

Updated ‘README.md’ removing stale example URLs
(<a href="https://github.com/eddelbuettel/drat/pull/63">[#63](https://github.com/eddelbuettel/drat/issues/63)</a>)

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.2 (2016-10-28)

<ul>
<li>

Changes in drat documentation

<ul>
<li>

The FAQ vignette added a new question <em>Why use drat</em>

</li>
<li>

URLs were made canonical, omegahat.net was updated from .org

</li>
<li>

Several files (README.md, Description, help pages) were edited

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.1 (2016-08-07)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

Use <code>dir.exists</code>, leading to versioned Depends on R (\>=
3.2.0)

</li>
<li>

Optionally pull remote before insert (Mark in PR
<a href="https://github.com/eddelbuettel/drat/pull/38">[#38](https://github.com/eddelbuettel/drat/issues/38)</a>)

</li>
<li>

Fix support for dots (Jan G. in PR
<a href="https://github.com/eddelbuettel/drat/pull/40">[#40](https://github.com/eddelbuettel/drat/issues/40)</a>)

</li>
<li>

Accept dots in package names (Antonio in PR
<a href="https://github.com/eddelbuettel/drat/pull/48">[#48](https://github.com/eddelbuettel/drat/issues/48)</a>)

</li>
<li>

Switch to htpps URLs at GitHub (Colin in PR
<a href="https://github.com/eddelbuettel/drat/pull/50">[#50](https://github.com/eddelbuettel/drat/issues/50)</a>)

</li>
<li>

Support additional fields in PACKAGE file (Jan G. in PR
<a href="https://github.com/eddelbuettel/drat/pull/54">[#54](https://github.com/eddelbuettel/drat/issues/54)</a>)

</li>
</ul>
</li>
<li>

Changes in drat documentation

<ul>
<li>

Further improvements and clarifications to vignettes

</li>
<li>

Travis script switched to <code>run.sh</code> from our fork

</li>
<li>

This NEWS file was (belatedly) added

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.1.0 (2015-08-08)

<ul>
<li>

Changes in drat functionality

<ul>
<li>

New function to optionally archive packages when inserting

</li>
<li>

Improved OS X support

</li>
</ul>
</li>
<li>

Changes in drat documentation

<ul>
<li>

Added note about miniCRAN to FAQ vignette

</li>
<li>

DESCRIPTION now credits all contributors

</li>
<li>

Updated / expanded vignettes

</li>
</ul>
</li>
</ul>

## Changes in drat version 0.0.4 (2015-05-26)

<ul>
<li>

Corrections to vignettes

</li>
<li>

Added Windows and OS X support (Jan Schulz in PR
<a href="https://github.com/eddelbuettel/drat/pull/16">[#16](https://github.com/eddelbuettel/drat/issues/16)</a>)

</li>
<li>

New vignette <em>Drat FAQ</em> started

</li>
<li>

More improvement to code and behaviour

</li>
</ul>

## Changes in drat version 0.0.3 (2015-04-10)

<ul>
<li>

Small extensions and corrections to existing functionality

</li>
<li>

New helper script <code>git2targz.sh</code>

</li>
<li>

Improved documentation

</li>
<li>

New vignette by Steven Pav on <em>Why Drat?</em>

</li>
<li>

New vignette by Colin Gilespie on <em>Drat and Travis</em>

</li>
<li>

New vignettes for package authors, and users

</li>
</ul>

## Changes in drat version 0.0.2 (2015-03-01)

<ul>
<li>

Added (optional) <span class="pkg">git2r</span> support

</li>
<li>

New <code>pruneRepo()</code> functionality

</li>
</ul>

## Changes in drat version 0.0.1 (2015-02-04)

<ul>
<li>

Initial version with <code>insert()</code>, <code>add()</code> and more

</li>
</ul>