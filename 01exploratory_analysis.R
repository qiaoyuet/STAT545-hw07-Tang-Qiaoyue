# Exploratory Analyses

# Libaries
library(ggplot2)
library(dplyr)
library(forcats)

# Bring in data as dataframe
gapminder <- read.delim("gapminder.tsv")

# Descriptive Plots
ggplot(gapminder, aes(year, lifeExp, color = continent)) + 
  geom_line(aes(group=country), alpha=0.5) +
  ggtitle("Life Expectancy vs. Year for All countries") + 
  labs(x="Year", y="Life Expectancy") +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("lifeexp_vs_year.png", width = 10, height = 5)

ggplot(gapminder, aes(x=year, y=gdpPercap, color = continent)) + 
  geom_line(aes(group=country), alpha=0.5) +
  ggtitle("GDP vs. Year for All countries") + 
  labs(x="Year", y="GDP") +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("gdp_vs_year.png", width = 10, height = 5)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point(aes(color=continent), alpha=0.5) + 
  scale_x_log10() +
  ggtitle("Life Expectancy vs. GDP for All countries") + 
  labs(x="Year", y="Life Expectancy") +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("gdp_vs_lifeexp.png", width = 10, height = 5)

ggplot(gapminder, aes(x=year, y=pop)) +
  geom_point(aes(color=continent), alpha=0.5) + 
  ggtitle("Population vs. Year for All countries") + 
  labs(x="Year", y="Population") +
  theme(plot.title = element_text(hjust = 0.5))
ggsave("pop_vs_year.png", width = 10, height = 5)

# Reorder the continents based on life expectancy
old_levels <- levels(gapminder$continent)
new_levels <- fct_reorder(gapminder$continent, gapminder$lifeExp, fun = max, desc = F) %>% 
  levels()

# Sort the actual data in a deliberate fashion using new levels of continent
gapminder2 <- gapminder %>%
  mutate(continent = factor(as.character(continent), new_levels),
         food = fct_recode(country, 
                           "Sushi" = "Japan",
                           "DimSum" = "China",
                           "Poutine" = "Canada",
                           "Chili" = "Chile",
                           "Fish&Chips" = "United Kingdom",
                           "Wine" = "France",
                           "Chocolate" = "Belgium",
                           "Taco" = "Mexico",
                           "Kimchi" = "Korea, Rep.",
                           "Porridge" = "Zambia",
                           "Boerewors" = "South Africa",
                           "Chapati" = "Tanzania",
                           "Milk" = "New Zealand",
                           "kangaroo" = "Australia")) %>%
  filter(country %in% c("Japan", "Canada", "United Kingdom", "Mexico", "Korea, Rep.",
                        "China","Chile","France","Belgium","Zambia","South Africa",
                        "Tanzania","New Zealand","Australia")) %>%
  arrange(lifeExp) %>%
  droplevels()

# Write the Gapminder data to file
write.table(gapminder2, "gapminder2.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)
