

# Move older copies of packages to an archive

[**Source code**](https://github.com/eddelbuettel/drat/tree/master/R/#L)

## Description

The function moves older versions of packages into a CRAN-style archive
folder.

## Usage

<pre><code class='language-R'>archivePackages(repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "binary", "mac.binary", "mac.binary.big-sur-x86_64",
  "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
  "win.binary", "both"), pkg, version = getRversion())

archivePackagesForAllRversions(repopath = getOption("dratRepo", "~/git/drat"),
  type = c("source", "binary", "mac.binary", "mac.binary.big-sur-x86_64",
  "mac.binary.big-sur-arm64", "mac.binary.el-capitan", "mac.binary.mavericks",
  "win.binary", "both"), pkg)
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
“binary”, “win.binary”, “mac.binary”, “mac.binary.big-sur-x86_64”,
“mac.binary.big-sur-arm64”, “mac.binary.mavericks”,
“mac.binary.el-capitan” or “both”
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="pkg">pkg</code>
</td>
<td>
Optional character variable specifying a package name(s), whose older
versions should be archived. If missing (the default), archiving is
performed on all packages.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="version">version</code>
</td>
<td>
R version information in the format <code>X.Y</code> or
<code>X.Y.Z</code>. Only used, if archiving binary packages. (default:
<code>version = getRversion()</code>). If <code>version = NA</code>, all
available R versions will be used. If <code>version = NULL</code>, this
defaults to <code>getRversion()</code>.
</td>
</tr>
</table>

## Details

This function is still undergoing development and polish and may change
in subsequent versions.

## Author(s)

Thomas J. Leeper

## Examples

``` r
library("drat")

  archivePackages()   # archive all older package versions
  archivePackages(pkg = "drat")  # archive older copies of just one package
```
