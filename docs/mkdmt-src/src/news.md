<div class="container">
<h3 id="version-0.2.2-2021-12-01">Version 0.2.2 (2021-12-01)</h3>
<ul>
<li><p>Travis artifacts and badges have been pruned</p></li>
<li><p>Vignettes now use <code>simplermarkdown</code></p></li>
</ul>
<h3 id="version-0.2.1-2021-07-09">Version 0.2.1 (2021-07-09)</h3>
<ul>
<li><p>Two internal functions now have a note in their documentation stating them as not exported (Dirk in response to <a href="https://github.com/eddelbuettel/drat/issues/123">#123</a>)</p></li>
<li><p>Repositories created by <code>initRepo</code> now have an placeholder <code>index.html</code> to not trigger a <code>curl</code> check at CRAN (Dirk)</p></li>
<li><p>Adding to a repository now checks for a top-level <code>index.html</code> and displays a message if missing (Dirk)</p></li>
<li><p>The DratStepByStep.Rmd vignette mentions the added <code>index.html</code> file</p></li>
</ul>
<h3 id="version-0.2.0-2021-04-21">Version 0.2.0 (2021-04-21)</h3>
<ul>
<li><p>A documentation website for the package was added at <a href="https://eddelbuettel.github.io/drat/">https://eddelbuettel.github.io/drat/</a> (Dirk)</p></li>
<li><p>The continuous integration was switched to using ‘r-ci’ (Dirk)</p></li>
<li><p>The <code>docs/</code> directory of the main repository branch can now be used instead of <code>gh-pages</code> branch (Dirk in <a href="https://github.com/eddelbuettel/drat/pull/112">#112</a>)</p></li>
<li><p>A new repository <a href="https://github.com/drat-base/drat">https://github.com/drat-base/drat</a> can now be used to fork an initial <code>drat</code> repository (Dirk)</p></li>
<li><p>A new vignette “Drat Step-by-Step” was added (Roman Hornung and Dirk in <a href="https://github.com/eddelbuettel/drat/pull/117">#117</a> fixing <a href="https://github.com/eddelbuettel/drat/issues/115">#115</a> and <a href="https://github.com/eddelbuettel/drat/issues/113">#113</a>)</p></li>
<li><p>The test suite was refactored for <code>docs/</code> use (Felix Ernst in <a href="https://github.com/eddelbuettel/drat/pull/118">#118</a>)</p></li>
<li><p>The minimum R version is now ‘R (&gt;= 3.6)’ (Dirk fixing <a href="https://github.com/eddelbuettel/drat/issues/119">#119</a>)</p></li>
<li><p>The vignettes were switched to <code>minidown</code> (Dirk fixing <a href="https://github.com/eddelbuettel/drat/issues/116">#116</a>)</p></li>
<li><p>A new test file was added to ensure ‘NEWS.Rd’ is always at the current release version.</p></li>
</ul>
<h3 id="version-0.1.8-2020-07-18">Version 0.1.8 (2020-07-18)</h3>
<ul>
<li><p>The archive pruning test code was corrected for r-oldrel (Felix Ernst in <a href="https://github.com/eddelbuettel/drat/pull/105">#105</a> fixing <a href="https://github.com/eddelbuettel/drat/issues/104">#104</a>).</p></li>
</ul>
<h3 id="version-0.1.7-2020-07-10">Version 0.1.7 (2020-07-10)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>Functions <code>insertPackages</code>, <code>archivePackages</code> and <code>prunePackages</code> are now vectorised (Patrick Schratz and Felix Ernst in <a href="https://github.com/eddelbuettel/drat/pull/93">#93</a>, <a href="https://github.com/eddelbuettel/drat/pull/100">#100</a>).</p></li>
<li><p>The new functionality is supported by unit tests (Felix Ernst in <a href="https://github.com/eddelbuettel/drat/pull/93">#93</a>, and <a href="https://github.com/eddelbuettel/drat/pull/102">#102</a> fixing <a href="https://github.com/eddelbuettel/drat/issues/101">#101</a>).</p></li>
<li><p>Added new function <code>updateRepo</code> (Felix Ernst in <a href="https://github.com/eddelbuettel/drat/pull/95">#95</a>, <a href="https://github.com/eddelbuettel/drat/pull/97">#97</a>).</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.6-2020-05-29">Version 0.1.6 (2020-05-29)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>Support for the various (current) macOS binary formats was rewritten (Felix Ernst in <a href="https://github.com/eddelbuettel/drat/pull/89">#89</a> fixing <a href="https://github.com/eddelbuettel/drat/issues/88">#88</a>).</p></li>
<li><p>Travis CI use was updated to R 4.0.0 and bionic (Dirk).</p></li>
<li><p>A drat repo was added to the README (Thomas Fuller in <a href="https://github.com/eddelbuettel/drat/pull/86">#86</a>)</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.5-2019-03-28">Version 0.1.5 (2019-03-28)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>Windows paths are handled better when inserting packages (Neal Fultz in <a href="https://github.com/eddelbuettel/drat/pull/70">#70</a>)</p></li>
<li><p>Binary packages are now supported for the <code>pruneRepo</code> and <code>archivePackages</code> commands (Christoph Stepper in <a href="https://github.com/eddelbuettel/drat/pull/79">#79</a>).</p></li>
</ul></li>
<li><p>Changes in drat documentation</p>
<ul>
<li><p>Properly prefix R path in <code>system</code> call in a tests (Dirk in minor cleanup to <a href="https://github.com/eddelbuettel/drat/pull/70">#70</a>).</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.4-2017-12-16">Version 0.1.4 (2017-12-16)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>Binaries for macOS are now split by R version into two different directories (Neal Futz in <a href="https://github.com/eddelbuettel/drat/pull/67">#67</a> addring <a href="https://github.com/eddelbuettel/drat/issues/64">#64</a>).</p></li>
<li><p>The target branch can now be set via a global option (Neal Futz in <a href="https://github.com/eddelbuettel/drat/pull/68">#68</a> addressing <a href="https://github.com/eddelbuettel/drat/issues/61">#61</a>).</p></li>
<li><p>In commit mode, add file <code>PACKAGES.rds</code> unconditionally.</p></li>
</ul></li>
<li><p>Changes in drat documentation</p>
<ul>
<li><p>Updated 'README.md' removing another stale example URL</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.3-2017-09-16">Version 0.1.3 (2017-09-16)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>Ensure 'PACKAGES.rds', if present, is also inserted in repo</p></li>
<li><p>Use https to fetch Travis CI script from r-travis</p></li>
</ul></li>
<li><p>Changes in drat documentation</p>
<ul>
<li><p>Updated 'README.md' removing stale example URLs (<a href="https://github.com/eddelbuettel/drat/pull/63">#63</a>)</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.2-2016-10-28">Version 0.1.2 (2016-10-28)</h3>
<ul>
<li><p>Changes in drat documentation</p>
<ul>
<li><p>The FAQ vignette added a new question <em>Why use drat</em></p></li>
<li><p>URLs were made canonical, omegahat.net was updated from .org</p></li>
<li><p>Several files (README.md, Description, help pages) were edited</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.1-2016-08-07">Version 0.1.1 (2016-08-07)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>Use <code>dir.exists</code>, leading to versioned Depends on R (&gt;= 3.2.0)</p></li>
<li><p>Optionally pull remote before insert (Mark in PR <a href="https://github.com/eddelbuettel/drat/pull/38">#38</a>)</p></li>
<li><p>Fix support for dots (Jan G. in PR <a href="https://github.com/eddelbuettel/drat/pull/40">#40</a>)</p></li>
<li><p>Accept dots in package names (Antonio in PR <a href="https://github.com/eddelbuettel/drat/pull/48">#48</a>)</p></li>
<li><p>Switch to htpps URLs at GitHub (Colin in PR <a href="https://github.com/eddelbuettel/drat/pull/50">#50</a>)</p></li>
<li><p>Support additional fields in PACKAGE file (Jan G. in PR <a href="https://github.com/eddelbuettel/drat/pull/54">#54</a>)</p></li>
</ul></li>
<li><p>Changes in drat documentation</p>
<ul>
<li><p>Further improvements and clarifications to vignettes</p></li>
<li><p>Travis script switched to <code>run.sh</code> from our fork</p></li>
<li><p>This NEWS file was (belatedly) added</p></li>
</ul></li>
</ul>
<h3 id="version-0.1.0-2015-08-08">Version 0.1.0 (2015-08-08)</h3>
<ul>
<li><p>Changes in drat functionality</p>
<ul>
<li><p>New function to optionally archive packages when inserting</p></li>
<li><p>Improved OS X support</p></li>
</ul></li>
<li><p>Changes in drat documentation</p>
<ul>
<li><p>Added note about miniCRAN to FAQ vignette</p></li>
<li><p>DESCRIPTION now credits all contributors</p></li>
<li><p>Updated / expanded vignettes</p></li>
</ul></li>
</ul>
<h3 id="version-0.0.4-2015-05-26">Version 0.0.4 (2015-05-26)</h3>
<ul>
<li><p>Corrections to vignettes</p></li>
<li><p>Added Windows and OS X support (Jan Schulz in PR <a href="https://github.com/eddelbuettel/drat/pull/16">#16</a>)</p></li>
<li><p>New vignette <em>Drat FAQ</em> started</p></li>
<li><p>More improvement to code and behaviour</p></li>
</ul>
<h3 id="version-0.0.3-2015-04-10">Version 0.0.3 (2015-04-10)</h3>
<ul>
<li><p>Small extensions and corrections to existing functionality</p></li>
<li><p>New helper script <code>git2targz.sh</code></p></li>
<li><p>Improved documentation</p></li>
<li><p>New vignette by Steven Pav on <em>Why Drat?</em></p></li>
<li><p>New vignette by Colin Gilespie on <em>Drat and Travis</em></p></li>
<li><p>New vignettes for package authors, and users</p></li>
</ul>
<h3 id="version-0.0.2-2015-03-01">Version 0.0.2 (2015-03-01)</h3>
<ul>
<li><p>Added (optional) <code>git2r</code> support</p></li>
<li><p>New <code>pruneRepo()</code> functionality</p></li>
</ul>
<h3 id="version-0.0.1-2015-02-04">Version 0.0.1 (2015-02-04)</h3>
<ul>
<li><p>Initial version with <code>insert()</code>, <code>add()</code> and more</p></li>
</ul>
</div>
