EXEC	:= pdflatex
FILES	:= $(wildcard *.tex)

report: report.tex $(FILES)
	pdflatex $<

all: report

clean:
	rm -rf *.pdf \
		*.log \
		*.prv \
		*.toc \
		*.aux \
		*.gz \
		*.out
	
.DEFAULT_GOAL 	:= all
.PHONY: all clean
