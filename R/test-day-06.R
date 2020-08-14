# chelsey
# daily exercise #6
# 08-12-2020

---
# answering Q1 #

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  select(date, state, cases) %>%
  summarize(state_total = sum(cases)) %>%
  ungroup() %>%
  slice_max(state_total, n = 6) %>%
  pull(state) -> top_states

covid %>%
  filter(state %in% top_states) %>%
  group_by(state, date) %>%
  summarize(state_daily_cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = state_daily_cases, color = state)) +
  facet_wrap(~state) +
  geom_line(size = 1) +
  labs(title = "6 top states with most current cases", x = 'date', y = "daily total cases", caption = "Daily exercise 06", subtitle = "sourse: NY Times", color = "", size = 1) +
  ggthemes::theme_gdocs()

ggsave(file = "img/test-img.png")

---
# answering Q2

library(tidyverse)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = read_csv(url)

covid %>%
  group_by(date) %>%
  summarise(total_cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = total_cases)) +
  geom_col(fill = 'purple', color = "yellow", alpha = .25) +
  geom_line(color = "black", size = 1) +
  ggthemes::theme_gdocs() +
  labs(title = "National Cummulative Case Counts",
       x = "Date",
       y = "Cases",
       caption = "Daily Exercise 06")
