library(tidyverse)
library(sf)
library(USAboundaries)

get_conus = function(data, var){
  filter(data, !get(var) %in% c("Alaska", "Hawaii", "Puerto Rico"))
}

cities = read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  get_conus("state_name") %>%
  select(city)

polygon = get_conus(us_states()) %>%
  select(name)

cj = st_join(polygon, cities)
