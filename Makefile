all: gapminder.tsv

clean:
	rm -f gapminder.tsv

gapminder.tsv:
	Rscript download_gapminder.R