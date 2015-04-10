#!/usr/bin/r

library(rmarkdown)
sapply(dir(".", "*.Rmd"), render, output_format="all")

