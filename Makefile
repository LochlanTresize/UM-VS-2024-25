.PHONY: main clean 

main: poster.pdf

poster.pdf: 
	latexmk -pdflua  poster.tex

clean: latexmkrc
	latexmk -pdflua -C
