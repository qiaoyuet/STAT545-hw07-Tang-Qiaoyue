# Exploratory Analyses

# Libaries
library(ggplot2)
library(dplyr)
library(forcats)

# Bring in data as dataframe
gapminder <- read.delim("gapminder.tsv")

# Descriptive Plots
ggplot(gapminder, aes(year, lifeExp, colour=continent)) + geom_smooth(method="lm", se=FALSE)
ggsave("lifeexp_vs_year.png")

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(aes(color=continent), alpha=0.5) + scale_x_log10()
ggsave("gdp_vs_lifeexp.png")

# Reorder the continents based on life expectancy
old_levels <- levels(gapminder$continent)
new_levels <- fct_reorder(gapminder$continent, gapminder$lifeExp, fun = max, desc = F) %>% 
  levels()

# Sort the actual data in a deliberate fashion using new levels of continent
gapminder <- gapminder %>%
  mutate(continent = factor(as.character(continent), new_levels),
         food = fct_recode(country, 
                           "Sushi" = "Japan",
                           "Poutine" = "Canada",
                           "Fish&Chips" = "United Kingdom",
                           "Taco" = "Mexico",
                           "Kimchi" = "Korea, Rep.")) %>%
  filter(country %in% c("Japan", "Canada", "United Kingdom", "Mexico", "Korea, Rep.")) %>%
  arrange(lifeExp) %>%
  droplevels()

# Write the Gapminder data to file
write.table(gapminder, "gapminder2.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)