
sources := 		$(wildcard *.Rmd)
vignettes := 		$(sources:.Rmd=.html)

all:			${vignettes}

%.html:			%.Rmd
			r -lrmarkdown -e"render(\"$<\")"


