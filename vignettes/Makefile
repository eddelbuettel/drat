
rmdsources :=		$(wildcard *.Rmd)
rmdvignettes :=		$(rmdsources:.Rmd=.html)

all:			${rmdvignettes}

%.html:			%.Rmd
			r -lrmarkdown -e"render(\"$<\")"
