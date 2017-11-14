all: gapminder.tsv

clean:
	rm -f gapminder.tsv gapminder2.tsv

gapminder.tsv:
	Rscript download_gapminder.R

gapminder2.tsv lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png: exploratory_analysis.R gapminder.tsv
	Rscript -e rmarkdown::render('exploratory_analysis.R')

lm_info.csv: gapminder2.tsv statistical_analysis.R
	Rscript -e rmarkdown::render('statistical_analysis.R')

lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Ameicas.png: gapminder2.tsv figures.R
	Rscript figures.R