# Generate figures

# Libraries
library(ggplot2)
library(dplyr)
library(glue)

# Create a figure for each continent, and write one file per continent, 
# with an informative name. The figure should give scatterplots of life expectancy vs. year, 
# faceting on country, fitted line overlaid.

p1 <- gapminder2 %>% filter(continent == "Asia") %>% group_by(country)
p2 <- gapminder2 %>% filter(continent == "Africa") %>% group_by(country)
p3 <- gapminder2 %>% filter(continent == "Europe") %>% group_by(country)
p4 <- gapminder2 %>% filter(continent == "Oceania") %>% group_by(country)
p5 <- gapminder2 %>% filter(continent == "Americas") %>% group_by(country)

ggplot(p1, aes(year, lifeExp, colour = country)) + geom_point() + geom_smooth(method="lm", se=FALSE) + facet_wrap(~ country)
ggsave("lifeExp_vs_year_in_Asia")

ggplot(p2, aes(year, lifeExp, colour = country)) + geom_point() + geom_smooth(method="lm", se=FALSE) + facet_wrap(~ country)
ggsave("lifeExp_vs_year_in_Africa")

ggplot(p3, aes(year, lifeExp, colour = country)) + geom_point() + geom_smooth(method="lm", se=FALSE) + facet_wrap(~ country)
ggsave("lifeExp_vs_year_in_Europe")

ggplot(p4, aes(year, lifeExp, colour = country)) + geom_point() + geom_smooth(method="lm", se=FALSE) + facet_wrap(~ country)
ggsave("lifeExp_vs_year_in_Oceania")

ggplot(p5, aes(year, lifeExp, colour = country)) + geom_point() + geom_smooth(method="lm", se=FALSE) + facet_wrap(~ country)
ggsave("lifeExp_vs_year_in_Ameicas")

# continent <- c("Asia","Europe","Africa","Americas","Oceania")
# for(i in continent) {
#   p <- gapminder2 %>% filter(continent == i) %>% group_by(country)
#   ggplot(p, aes(year, lifeExp, colour = country)) + geom_point() + geom_smooth(method="lm", se=FALSE) + facet_wrap(~ country)
#   ggsave(glue("lifeExp_vs_year_in_{i}"))
# }