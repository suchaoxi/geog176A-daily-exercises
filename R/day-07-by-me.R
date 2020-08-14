# Chelsey Su
# 08-12-2020
# daily exercise 07

---
library(tidyverse)

library(USAboundaries)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = read_csv(url)

state = USAboundaries::us_states(resolution = "low")

region = data.frame(state = state.name, region = state.region)

covid %>%
  group_by(state) %>%
  summarize(n = n()) %>%
  ungroup() %>%
  inner_join(state, by = c("state" = "state.name"))


