all: hw07_report.html lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png

clean:
	rm -f gapminder.tsv gapminder2.tsv lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png lm_info.tsv lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Americas.png hw07_report.html pop_vs_year.png

gapminder.tsv:
	Rscript 00download_gapminder.R

gapminder2.tsv lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png pop_vs_year.png: gapminder.tsv
	Rscript 01exploratory_analysis.R
	rm Rplots.pdf

lm_info.tsv: gapminder2.tsv
	Rscript 02statistical_analysis.R

lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Ameicas.png: gapminder2.tsv lm_info.tsv
	Rscript 03figures.R

hw07_report.html: hw07_report.rmd gapminder.tsv gapminder2.tsv lm_info.tsv lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Ameicas.png lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png pop_vs_year.png
	Rscript -e 'rmarkdown::render("$<")'