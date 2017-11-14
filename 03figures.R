# Generate figures

# Libraries
library(ggplot2)
library(dplyr)

# Create a figure for each continent, and write one file per continent, 
# with an informative name. The figure should give scatterplots of life expectancy vs. year, 
# faceting on country, fitted line overlaid.
gapminder2 <- read.delim("gapminder2.tsv")
# p1 <- gapminder2 %>% filter(continent == "Asia") %>% group_by(country)
# p2 <- gapminder2 %>% filter(continent == "Africa") %>% group_by(country)
# p3 <- gapminder2 %>% filter(continent == "Europe") %>% group_by(country)
# p4 <- gapminder2 %>% filter(continent == "Oceania") %>% group_by(country)
# p5 <- gapminder2 %>% filter(continent == "Americas") %>% group_by(country)
# 
# ggplot(p1, aes(year, lifeExp, colour = country)) + 
#   geom_point() + 
#   geom_smooth(method="lm", se=FALSE) + 
#   facet_wrap(~ country) +
#   ggtitle("Life Expectancy vs. Year in Asia") + 
#   labs(x="Year", y="Life Expectancy") +
#   theme(plot.title = element_text(hjust = 0.5)) +
#   theme(axis.text.x = element_text(angle=45))
# ggsave("lifeExp_vs_year_in_Asia.png", width = 10, height = 5)
# 
# ggplot(p2, aes(year, lifeExp, colour = country)) + 
#   geom_point() + 
#   geom_smooth(method="lm", se=FALSE) + 
#   facet_wrap(~ country) +
#   ggtitle("Life Expectancy vs. Year in Africa") + 
#   labs(x="Year", y="Life Expectancy") +
#   theme(plot.title = element_text(hjust = 0.5)) +
#   theme(axis.text.x = element_text(angle=45))
# ggsave("lifeExp_vs_year_in_Africa.png", width = 10, height = 5)
# 
# ggplot(p3, aes(year, lifeExp, colour = country)) + 
#   geom_point() + 
#   geom_smooth(method="lm", se=FALSE) + 
#   facet_wrap(~ country) +
#   ggtitle("Life Expectancy vs. Year in Europe") + 
#   labs(x="Year", y="Life Expectancy") +
#   theme(plot.title = element_text(hjust = 0.5)) +
#   theme(axis.text.x = element_text(angle=45))
# ggsave("lifeExp_vs_year_in_Europe.png", width = 10, height = 5)
# 
# ggplot(p4, aes(year, lifeExp, colour = country)) + 
#   geom_point() + 
#   geom_smooth(method="lm", se=FALSE) + 
#   facet_wrap(~ country) +
#   ggtitle("Life Expectancy vs. Year in Oceania") + 
#   labs(x="Year", y="Life Expectancy") +
#   theme(plot.title = element_text(hjust = 0.5)) +
#   theme(axis.text.x = element_text(angle=45))
# ggsave("lifeExp_vs_year_in_Oceania.png", width = 10, height = 5)
# 
# ggplot(p5, aes(year, lifeExp, colour = country)) + 
#   geom_point() + 
#   geom_smooth(method="lm", se=FALSE) + 
#   facet_wrap(~ country) +
#   ggtitle("Life Expectancy vs. Year in Amricas") + 
#   labs(x="Year", y="Life Expectancy") +
#   theme(plot.title = element_text(hjust = 0.5)) +
#   theme(axis.text.x = element_text(angle=45))
# ggsave("lifeExp_vs_year_in_Americas.png", width = 10, height = 5)


continent <- c("Asia","Europe","Africa","Americas","Oceania")
for(i in continent) {
  p <- gapminder2 %>% filter(continent == i) %>% group_by(country)
  ggplot(p, aes(year, lifeExp, colour = country)) + 
    geom_point() + 
    geom_smooth(method="lm", se=FALSE) + 
    facet_wrap(~ country) +
    ggtitle(paste0("Life Expectancy vs. Year in ", i)) + 
    labs(x="Year", y="Life Expectancy") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(axis.text.x = element_text(angle=45))
  ggsave(paste0("lifeExp_vs_year_in_", i, ".png"), width = 10, height = 5)
}
