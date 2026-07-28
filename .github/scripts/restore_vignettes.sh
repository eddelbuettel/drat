#!/bin/sh

test -d vignettes.altdoc || exit 0
test -d docs || exit 0

rm -rf vignettes
mv vignettes.altdoc vignettes
