# Chelsey Su
# 8-24-2020
# daily exercise 12

library(tidyverse)
library(sf)
library(USAboundaries)

states = us_states() %>%
  filter(!(name %in% c("Puerto Rico", "Alaska", "Hawaii")))

colorado = us_states() %>%
  filter(name == "Colorado")

touchesCO = st_filter(states, colorado, .predicate = st_touches)

ggplot() +
  geom_sf(data = states, fill = "#d1c7ab", color = "#baa368") +
  geom_sf(data = colorado, fill = "#bc8de0") +
  geom_sf(data = touchesCO, fill = "#c9b6d9") +
  theme_light() +
  geom_label(data = colorado, aes(label = name, geometry = geometry), stat = "sf_coordinates", size = 2) +
  geom_label(data = touchesCO, aes(label = name, geometry = geometry), stat = "sf_coordinates", size = 1) +
  labs(title = "States that Touches Colorado Boarder", x = "Longitude", y = "Latitude") +
  ggsave(file = "img/state_touches_CO.png")
