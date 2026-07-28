
mdsources :=		$(wildcard *.md)
mdvignettes :=		$(mdsources:.md=.html)

all:			${mdvignettes}

clean:
			rm -f ${mdvignettes}

%.html:			%.md
			Rscript -e 'simplermarkdown::mdweave_to_html("$<")'
