

# Add a (drat) repository to the current session

[**Source code**](https://github.com/eddelbuettel/drat/tree/master/R/#L)

## Description

R can use multiple archives: CRAN, BioConductor and Omegahat have been
supported for years. It is equally easy to add local archives from the
same machine, or local network, or university / company network as well
as other publically available repositories. This function aids in the
process, and defaults to adding a ‘drat’ archive at GitHub under the
given account.

## Usage

<pre><code class='language-R'>addRepo(account, alturl)

add(...)
</code></pre>

## Arguments

<table role="presentation">
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="account">account</code>
</td>
<td>
Character vector with one or more GitHub account for which a ‘drat’
archive is to be added.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="alturl">alturl</code>
</td>
<td>
Alternative repo specification with a complete url string. If ‘alturl’
is provided, a single ‘account’ must be provided as well. For file-based
access, the URL format has to follow the <code>file:/some/path/</code>
format starting with ‘file’ followed by a single colon.
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="...">…</code>
</td>
<td>
For the aliases variant, a catch-all collection of parameters.
</td>
</tr>
</table>

## Details

This function retrieves the current set of repositories (see
<code>getOption(“repos”)</code> for the current values) and adds (or
overwrites) the entry for the given ‘account’. For non-GitHub
repositories an alternative URL can be specified as ‘alturl’ (and
assigned to ‘account’ as well).

An aliased function <code>add</code> is also available, but not exported
via <code>NAMESPACE</code> to not clobber a possibly unrelated function;
use it via <code>drat:::add()</code>.

## Value

The altered set of repositories

## Author(s)

Dirk Eddelbuettel

## Examples

``` r
library("drat")

  addRepo("drat")                            # adds GitHub repo via default URL
  addRepo(c("eddelbuettel", "ghrr"))         # ditto but adds two repos at once

  addRepo("LocalRepo", "file:/nas/R/repo")   # adds local file-based repo,
                                             # assumes you can read /nas/R/repo
```
