# Statistical Analyses

# Libaries
library(broom)
library(dplyr)
library(forcats)

# Import the data created in the first script.
gapminder2 <- read.delim("gapminder2.tsv")

# Make sure your new continent order is still in force.
old_levels2 <- levels(gapminder2$continent)
new_levels2 <- fct_reorder(gapminder2$continent, gapminder2$lifeExp, fun = max, desc = F) %>% 
  levels()

# Fit a linear regression of life expectancy on year within selected countries. 
model.k <- lm(lifeExp~year, data = gapminder2, subset = (country == "Korea, Rep."))
df1 <- tidy(model.k)
model.j <- lm(lifeExp~year, data = gapminder2, subset = (country == "Japan"))
df2 <- tidy(model.j)
model.c <- lm(lifeExp~year, data = gapminder2, subset = (country == "Canada"))
df3 <- tidy(model.c)
model.uk <- lm(lifeExp~year, data = gapminder2, subset = (country == "United Kingdom"))
df4 <- tidy(model.uk)
model.m <- lm(lifeExp~year, data = gapminder2, subset = (country == "Mexico"))
df5 <- tidy(model.m)

# Write the estimated intercepts, slopes, and residual error variance (or sd) to file. 
country = c("Korea, Rep.","Japan","Canada","United Kingdom","Mexico")
intercept.estimate = c(df1$estimate[1], df2$estimate[1], 
                       df3$estimate[1], df4$estimate[1], df5$estimate[1])
intercept.se = c(df1$std.error[1], df2$std.error[1], 
                 df3$std.error[1], df4$std.error[1], df5$std.error[1])
slope.estimate = c(df1$estimate[2], df2$estimate[2], 
                   df3$estimate[2], df4$estimate[2], df5$estimate[2])
slope.se = c(df1$std.error[2], df2$std.error[2], 
             df3$std.error[2], df4$std.error[2], df5$std.error[2])

lm_info <- data.frame(country, intercept.estimate,intercept.se,slope.estimate,slope.se)

write.table(lm_info, "lm_info.tsv")

# Find out which country are the best in terms of highest life expectancies for each continent.
continent <- c("Asia","Europe","Africa","Americas","Oceania")
for (i in continent) {
  tmp <- gapminder2 %>%
    filter(continent == i) %>%
    arrange(desc(lifeExp))
    print(list("country_max_lifeExp"=tmp[1, ]$country, "continent"=tmp[1, ]$continent, "max_lifeExp"=tmp[1, ]$lifeExp))
}