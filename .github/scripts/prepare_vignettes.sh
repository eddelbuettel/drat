#!/bin/sh

test -d vignettes || exit 0
test -d docs || exit 0
test -d docs/vignettes || exit 0

cp -ax vignettes vignettes.altdoc

for file in vignettes/*.md; do
    basename=$(basename ${file} .md)
    #echo "*** file ${file} ${basename}"
    sed -i -e '/^---$/,/^---$/d' ${file}
    rm -f vignettes/${basename}.html
done
