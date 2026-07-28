

# Insert a package source or binary file into a drat repository

[**Source code**](https://github.com/eddelbuettel/drat/tree/master/R/#L)

## Description

R can use multiple archives: CRAN, BioConductor and Omegahat have been
supported for years. It is equally easy to add local archives from the
same machine, or local network, or university / company network as well
as other publically available repositories. This function aids in the
process, and defaults to inserting a given source archive into a given
repository.

## Usage

<pre><code class='language-R'>insertPackage(file, repodir = getOption("dratRepo", "~/git/drat"),
  commit = FALSE, pullfirst = FALSE, action = c("none", "archive",
  "prune"), location = getOption("dratBranch", "gh-pages"),
  OSflavour = character(), ...)

insertPackages(file, ...)

insert(...)
</code></pre>

## Arguments

<table role="presentation">
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="file">file</code>
</td>
<td>
One or more R package(s) in source or binary format
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="repodir">repodir</code>
</td>
<td>
A local directory corresponding to the repository top-level directory.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="commit">commit</code>
</td>
<td>
Either boolean toggle to select automatic git operations ‘add’,
‘commit’, and ‘push’ or, alternatively, a character variable can be used
to specify a commit message; this also implies the ‘TRUE’ values in
other contexts.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="pullfirst">pullfirst</code>
</td>
<td>
Boolean toggle to call <code>git pull</code> before inserting the
package.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="action">action</code>
</td>
<td>
A character string containing one of: “none” (the default; add the new
package into the repo, effectively masking previous versions), “archive”
(place any previous versions into a package-specific archive folder,
creating such an archive if it does not already exist), or “prune”
(calling <code>pruneRepo</code>).
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="location">location</code>
</td>
<td>
A character variable with the GitHub Pages location: either “gh-pages”
indicating a branch of that name, or “docs/” directory in the main
branch. The default value can be overridden via the “dratBranch” option.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="OSflavour">OSflavour</code>
</td>
<td>
an optional string naming the OSflavour, which is otherwise read as the
second element of the ‘Built’ field of the <code>file</code>. For
packages that do not need compilation on macOS for R \>= 4.3 the ‘Built’
field is empty in the DESCRIPTION in a binary file (tgz), in which case
it can be useful to set the <code>OSflavour</code> e.g. by the value of
R.Version()$platform, so that <code>insertPackages</code> inserts the
binary into the appropriate sub folder (under bin/maxosx).
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="...">…</code>
</td>
<td>
For <code>insert</code> the aliases variant, a catch-all collection of
parameters. For <code>insertPackage</code> arguments passed to
<code>write_PACKAGES</code> currently include <code>latestOnly</code>,
for which the default value is set here to <code>FALSE</code>. See
<code>write_PACKAGES</code>.
</td>
</tr>
</table>

## Details

This function inserts the given (source or binary) package file into the
given (local) package repository and updates the index. By setting the
<code>commit</code> option to <code>TRUE</code>, one can then push to a
remote git code repository. If the <code>git2r</code> package is
installed, it is used for the interaction with the git repository;
otherwise the <code>git</code> shell command is used.

An aliased function <code>insert</code> is also available, but not
exported via <code>NAMESPACE</code> to not clobber a possibly unrelated
function; use it via <code>drat:::insert()</code>.

The function also checks for a top-level <code>index.html</code> file to
ensure external tests against the repository (as for example done by
CRAN if you list the repository as an ‘Additional_repositories’ in a
package) do not return a ‘404’ error. If missing, a simple one-line
example is shown.

## Value

NULL is returned.

## Options

Set using <code>options</code>

<dl>
<dt>
<code>dratRepo</code>
</dt>
<dd>
Path to git repo. Defaults to <code>~/git/drat</code>
</dd>
<dt>
<code>dratBranch</code>
</dt>
<dd>
The git branch to store packages on. Defaults to <code>gh-pages</code>
</dd>
</dl>

## Author(s)

Dirk Eddelbuettel

## Examples

``` r
library("drat")

  insertPackage("foo_0.2.3.tar.gz")   # inserts into (default) repo
  insertPackage("foo_0.2.3.tar.gz", "/nas/R/")  # ... into local dir

  insertPackage("foo_0.2.3.tar.gz", action = "prune")   # prunes any older copies
  insertPackage("foo_0.2.3.tar.gz", action = "archive")   # archives any older copies
```
