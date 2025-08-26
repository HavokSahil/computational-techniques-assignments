BUILD	:= pdflatex

report: report.tex report1.tex report2.tex report3.tex report4.tex a2.jpg a4.jpg
	pdflatex $<

clean:
	@rm -rf *.toc \
		*.aux \
		*.log \
		*.out

.PHONY: clean
.DEFAULT_GOAL: report
