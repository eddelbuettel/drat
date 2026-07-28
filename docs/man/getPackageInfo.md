

# Get information from a binary package

[**Source code**](https://github.com/eddelbuettel/drat/tree/master/R/#L)

## Description

This function returns the compile-time information added to the
<code>DESCRIPTION</code> file in the package.

## Usage

<pre><code class='language-R'>getPackageInfo(file, OSflavour = character())
</code></pre>

## Arguments

<table role="presentation">
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="file">file</code>
</td>
<td>
the fully qualified path of the package
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
</table>

## Value

A named vector with several components

## Note

This is an internal function, use <code>:::</code> to access it from
outside the internal package code.

## Author(s)

Dirk Eddelbuettel
