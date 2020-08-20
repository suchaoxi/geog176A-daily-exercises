# Chelsey Su
# 08/19/2020
# daily exercise #11

library(tidyverse)
library(sf)
library(USAboundaries)
library(units)

us_cities = readr::read_csv(file = "data/uscities.csv") %>%
  filter(state_name == "California", city %in% c("Santa Barbara", "Monterey Park")) %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) -> my_cities

my_cities %>%
  st_transform(5070) -> equal

my_cities %>%
  st_transform('+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs') -> eqidistance

st_distance(my_cities)
st_distance(equal)
st_distance(eqidistance)

st_distance(my_cities) %>%
  set_units("km") %>%
  drop_units()
