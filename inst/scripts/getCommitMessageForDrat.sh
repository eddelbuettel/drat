#!/bin/sh

url=$(grep url .git/config | cut -d' ' -f3 | head -1)
sha=$(git ls | head -1 | awk '{print $2}')
version=$(awk '/^Version:/ {print $2}' DESCRIPTION)
package=$(awk '/^Package:/ {print $2}' DESCRIPTION)

echo "${package} ${version} ${sha} ${url}"

