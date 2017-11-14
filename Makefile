all: hw07_report.html lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png

clean:
	rm -f gapminder.tsv gapminder2.tsv lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png lm_info.tsv lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Ameicas.png hw07_report.html

gapminder.tsv:
	Rscript download_gapminder.R

gapminder2.tsv lifeexp_vs_year.png gdp_vs_year.png gdp_vs_lifeexp.png: gapminder.tsv
	Rscript exploratory_analysis.R

lm_info.tsv: gapminder2.tsv
	Rscript statistical_analysis.R

lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Ameicas.png: gapminder2.tsv lm_info.tsv
	Rscript figures.R

hw07_report.html: hw07_report.rmd gapminder.tsv gapminder2.tsv lm_info.tsv lifeExp_vs_year_in_Asia.png lifeExp_vs_year_in_Africa.png lifeExp_vs_year_in_Europe.png lifeExp_vs_year_in_Oceania.png lifeExp_vs_year_in_Ameicas.png
	Rscript -e 'rmarkdown::render("$<")'