
rmdsources :=		$(wildcard *.Rmd)
rmdvignettes :=		$(rmdsources:.Rmd=.html)

mdsources :=		$(wildcard *.md)
mdvignettes :=		$(mdsources:.md=.html)

all:			${rmdvignettes} ${mdvignettes}

%.html:			%.Rmd
			r -lrmarkdown -e"render(\"$<\")"

%.html:			%.md
			r -lrmarkdown -e"render(\"$<\")"
