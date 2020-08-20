# Chelsey Su
# 8/19/2020
# daily exercise 10

library(tidyverse)
library(sf)
library(USAboundaries)

conus = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))

preserved = st_combine(conus) %>%
  st_cast("MULTILINESTRING")

plot(preserved)

dissolved = st_union(conus) %>%
  st_cast("MULTILINESTRING")

plot(dissolved)




