# Chelsey Su
# 08/26/2020
# daily exercise 14

library(tidyverse)
library(sf)
library(USAboundaries)

get_conus = function(data, var){
  filter(data, !get(var) %in% c("Alaska", "Hawaii", "Puerto Rico"))
}

cities = readr::read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  get_conus("state_name") %>%
  st_transform(5070)

counties = us_cities() %>%
  get_conus("state_name") %>%
  st_transform(5070)

point_in_polygon = function(points, polygon, geoid){
  st_join(points, polygon) %>%
    st_drop_geometry() %>%
    count(geoid)
}

plot_pip = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n), alpha = .9, size = .2)) +
    scale_fill_gradient(low = "white", high = "darkgreen") +
    theme_gray() +
    theme(legend.position = "none",
          plot.title = element_text(face = "bold", color = "darkgreen", hjust = .5, size = 24)) +
    labs(title = "Cities Number",
        caption = paste0(sum(data$n), "location represented"))
}

cities_pip = point_in_polygon(cities, counties) %>%
  plot_pip()

ggsave(file = "img/day-14.png")
