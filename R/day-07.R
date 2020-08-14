# Chelsey Su
# 08-12-2020
# daily exercise 07

---
library(tidyverse)

library(USAboundaries)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = read_csv(url)

region = data.frame(state = state.name, region = state.region)

covid %>%
  right_join(region, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases  = sum(cases), deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) -> covid_region

ggplot(covid_region, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_dark() +
  theme(legend.position = "bottom") +
  theme(legend.position = "NA") +
  labs(title = "Cummulative Cases and Deaths: Region", y = "Daily Cumulative Count", x = "Date", caption = "Daily Exercise 07", subtitle = "COVID-19 Data: NY-Times" )

ggsave(file = "img/day-07.png")
