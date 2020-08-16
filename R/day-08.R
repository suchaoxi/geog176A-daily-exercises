# Chelsey Su
# 08-15-2020
# daily exercise 08

---
library(tidyverse)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = read_csv(url)

state.of.interest = "California"

covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  mutate(new_cases = cases - lag(cases), roll_7 = rollmean(new_cases, 7, fill = NA, align = "right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = new_cases), fill = NA, color = "#d7c5f0") +
  geom_line(aes(y = roll_7), color = "#c3ace3", size = 1) +
  ggthemes::theme_wsj() +
  labs(title = paste("New cases by day in", state.of.interest)) +
  theme(plot.title = element_text(size = 15, face = 'bold')) +
  theme(aspect.ratio = .4)

ggsave(file = "img/day-08.png")
