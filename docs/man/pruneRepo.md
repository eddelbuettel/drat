

# Prune repository from older copies of packages

[**Source code**](https://github.com/eddelbuettel/drat/tree/master/R/#L)

## Description

The function determines which packages in a repositories can be removed
as they are being ‘shadowed’ by a newer version of the same packages.

## Usage

<pre><code class='language-R'>getRepoInfo(repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "binary", "mac.binary", "mac.binary.big-sur-x86_64",
  "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
  "win.binary", "both"), pkg, version = getRversion(),
  location = getOption("dratBranch", "gh-pages"))

pruneRepo(repopath = getOption("dratRepo", "~/git/drat"), type = c("source",
  "binary", "mac.binary", "mac.binary.big-sur-x86_64",
  "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
  "win.binary", "both"), pkg, version = getRversion(), remove = FALSE,
  location = getOption("dratBranch", "gh-pages"))

pruneRepoForAllRversions(repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "mac.binary", "mac.binary.big-sur-x86_64",
  "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
  "win.binary", "both"), pkg, remove = FALSE)

updateRepo(repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "mac.binary", "mac.binary.big-sur-x86_64",
  "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
  "win.binary", "both"), version = NA, ...)
</code></pre>

## Arguments

<table role="presentation">
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="repopath">repopath</code>
</td>
<td>
Character variable with the path to the repo; defaults to the value of
the “dratRepo” option with “"~/git/drat"” as fallback
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="type">type</code>
</td>
<td>
Character variable for the type of repository, so far “source”,
“binary”, “win.binary”, “mac.binary”, “mac.binary.mavericks”,
“mac.binary.el-capitan”, “mac.binary.big-sur-x86_64”,
“mac.binary.big-sur-arm64”, or “both”
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="pkg">pkg</code>
</td>
<td>
Optional character variable specifying a package name, whose older
versions should be pruned. If missing (the default), pruning is
performed on all packages.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="version">version</code>
</td>
<td>
R version information in the format <code>X.Y</code> or
<code>X.Y.Z</code>. Only used, if pruning binary packages. (default:
<code>version = getRversion()</code>). If <code>version = NA</code>, all
available R versions will be used. If <code>version = NULL</code>, this
defaults to <code>getRversion()</code>.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="location">location</code>
</td>
<td>
An optional character variable with the GitHub Pages location: either
“gh-pages” indicating a branch of that name, or “docs/” directory in the
main branch. The default value can be overridden via the “dratBranch”
option.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="remove">remove</code>
</td>
<td>
Character or logical variable indicating whether files should be
removed. Nothing happens if ‘FALSE’. If different from (logical) ‘FALSE’
and equal to character “git” files are removed via <code>git rm</code>
else via a straight file deletion.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="...">…</code>
</td>
<td>
For <code>updateRepo</code> a catch-all collection of parameters.
Arguments passed to <code>update_PACKAGES</code> currently include
<code>latestOnly</code>, for which the default value is set here to
<code>FALSE</code>. See <code>update_PACKAGES</code>. Please note that
this has an effect for <code>update_PACKAGES</code> only, if new
packages are found, e.g. manually added.
</td>
</tr>
</table>

## Details

Given a package name, R will always find the newest version of that
package. Older versions are therefore effectively shadowed and can be
removed without functionally changing a repository.

However, if a current package file is removed without
<code>pruneRepo</code>, the PACKAGES, PACKAGES.gz and PACKAGES.rds file
might be not up to date. To ensure the correct information is available
in these indices, run <code>updateRepo</code>.

These functions are still undergoing development and polish and may
change in subsequent versions.

## Value

A data frame describing the repository is returned containing columns
with columns “file”, “package” (just the name), “version” and a logical
variable “newest” indicating if the package can be removed.

## Author(s)

Dirk Eddelbuettel
