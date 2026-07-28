

# Identifies the package type from a filename

[**Source code**](https://github.com/eddelbuettel/drat/tree/master/R/#L)

## Description

This function identifies the package type from a filename.

## Usage

<pre><code class='language-R'>identifyPackageType(file, pkginfo = getPackageInfo(file))
</code></pre>

## Arguments

<table role="presentation">
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="file">file</code>
</td>
<td>
An R package in source or binary format,
</td>
</tr>
<tr>
<td style="white-space: nowrap; font-family: monospace; vertical-align: top">
<code id="pkginfo">pkginfo</code>
</td>
<td>
information on the R package referenced by <code>file</code>
</td>
</tr>
</table>

## Details

The returned string is suitable for <code>write_PACKAGES()</code>.

## Value

string Type of the supplied package.

## Note

This is an internal function, use <code>:::</code> to access it from
outside the internal package code.

## Author(s)

Jan Schulz and Dirk Eddelbuettel
