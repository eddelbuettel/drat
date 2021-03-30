## Identifies the package type from a filename

### Description

This function identifies the package type from a filename.

### Usage

    identifyPackageType(file, pkginfo = getPackageInfo(file))

### Arguments

| Argument  | Description                                       |
|-----------|---------------------------------------------------|
| `file`    | An R package in source or binary format,          |
| `pkginfo` | information on the R package referenced by `file` |

### Details

The returned string is suitable for `write_PACKAGES()`.

### Value

string Type of the supplied package.

### Author(s)

Jan Schulz and Dirk Eddelbuettel
