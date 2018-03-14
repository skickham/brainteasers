###############################################
### UCS Satellite Data on the World Map Lab ###
### NYC Data Science Academy                ###
###############################################

# Data gathered from the Union of Concerned Scientists
# http://www.ucsusa.org/nuclear-weapons/space-weapons/satellite-database

library(ggplot2)
library(tidyr)

# access world map from ggplot2
world <- map_data("world")

setwd("~/Downloads/ucs_satellite_maps/")
sat_data <- read.csv("ucs_satellites.csv", stringsAsFactors = T)

# The default stringsAsFactors=T helps with graphing.
# The data has been cleaned for your convenience and understanding.

################################################
### Graphing Satellites by Country of Origin ###
################################################

# How many satellites originate from each country? Let's save it in a dataframe for future use
country_origin_df <- group_by(sat_data, Country.Org.of.UN.Registry) %>% 
  summarise(count_from_orig_country = n()) %>% 
  arrange(desc(count_from_orig_country))
#   Country.Org.of.UN.Registry  count_from_orig_country
#                       <fctr>                    <int>
# 1                        USA                      399
# 2                         NR                      321
# 3                     Russia                      117
# 4                      China                      114
# 5                     France                       65
# 6                      Japan                       47


# Combine the "country_origin_df" with the "world" data frame:
new_world_map_df = full_join(world, country_origin_df, by=c("region" = "Country.Org.of.UN.Registry"))

head(filter(new_world_map_df, region=="UK"), 30) # looking good
#         long      lat group order region        subregion count_from_orig_country
# 1  -1.065576 50.69024   582 40953     UK    Isle of Wight                      32
# 2  -1.149365 50.65571   582 40954     UK    Isle of Wight                      32
# 3  -1.175830 50.61523   582 40955     UK    Isle of Wight                      32
# 4  -1.196094 50.59922   582 40956     UK    Isle of Wight                      32
# 5  -1.251465 50.58882   582 40957     UK    Isle of Wight                      32
# 6  -1.306299 50.58853   582 40958     UK    Isle of Wight                      32
# 7  -1.515332 50.66978   582 40959     UK    Isle of Wight                      32
# 8  -1.563428 50.66611   582 40960     UK    Isle of Wight                      32
# 9  -1.515674 50.70332   582 40961     UK    Isle of Wight                      32
# 10 -1.385840 50.73355   582 40962     UK    Isle of Wight                      32
# 11 -1.312793 50.77348   582 40963     UK    Isle of Wight                      32
# 12 -1.144239 50.73472   582 40964     UK    Isle of Wight                      32
# 13 -1.065576 50.69024   582 40965     UK    Isle of Wight                      32
# 14 -4.196777 53.32143   583 40967     UK            Wales                      32
# 15 -4.154883 53.30283   583 40968     UK            Wales                      32
# 16 -4.049366 53.30576   583 40969     UK            Wales                      32
# 17 -4.084278 53.26431   583 40970     UK            Wales                      32
# 18 -4.200391 53.21807   583 40971     UK            Wales                      32
# 19 -4.278613 53.17241   583 40972     UK            Wales                      32
# 20 -4.373047 53.13418   583 40973     UK            Wales                      32
# 21 -4.418848 53.17803   583 40974     UK            Wales                      32
# 22 -4.471973 53.17636   583 40975     UK            Wales                      32
# 23 -4.553223 53.26045   583 40976     UK            Wales                      32
# 24 -4.567871 53.38647   583 40977     UK            Wales                      32
# 25 -4.461719 53.41929   583 40978     UK            Wales                      32
# 26 -4.315088 53.41724   583 40979     UK            Wales                      32
# 27 -4.196777 53.32143   583 40980     UK            Wales                      32
# 28 -6.218018 54.08872   584 40982     UK Northern Ireland                      32
# 29 -6.303662 54.09487   584 40983     UK Northern Ireland                      32
# 30 -6.363672 54.07710   584 40984     UK Northern Ireland                      32

# What happens if you did an inner_join instead? 
# -> you lose all the geom_polygons with 0 satellites

# Note: Make sure your map data frame is sorted!
# Create world map and, using your combined dataframe, "fill" each country with the 
# the number of satellite origins per country
ggplot(data=new_world_map_df, aes(x=long, y=lat)) + 
  geom_polygon(aes(group=group, fill=count_from_orig_country)) +
  theme(legend.position="bottom", 
        axis.title.x=element_blank(), 
        axis.title.y=element_blank(), 
        axis.ticks=element_blank(), 
        axis.text.x=element_blank(), 
        axis.text.y=element_blank()) +
  scale_fill_continuous(name = "Origins per Country") +
  coord_equal() +
  ggtitle("Satellites by Country of Origin")

################################################
##### Graphing Launchpads Around the World #####
################################################

# Launch.Latitudes and Launch.Longitudes have been found for you manually

# How many satellites launch per Launch.Site?
launch_site_df = group_by(sat_data, Launch.Site) %>% 
  summarise(Launches_per_site = n())

# layer the geom_point() of the launches onto the geom_polygon() world map
ggplot() + geom_polygon(data = world, aes(x = long, y = lat, group = group)) + 
  geom_point(aes(x=sat_data$Launch.Longitude, 
                 y=sat_data$Launch.Latitude, 
                 size=launch_site_df$Launches_per_site[sat_data$Launch.Site]
  ), # end geom_point aesthetics
  col="royal blue") + # end geom_point()
  coord_equal() +
  scale_size_continuous(range = c(1, 3.5)) +
  theme(legend.position="none", 
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        axis.ticks = element_blank(), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank()) +
  ggtitle("Satellite Launch Pads by Number of Launches")
# Warning message:
# Removed 59 rows containing missing values (geom_point). 

# What are these 59 missing values? Why aren't they on the map?

# L-1011 Aircraft: https://i.ytimg.com/vi/m7_yyvGxwrE/hqdefault.jpg
# ISS: https://www.youtube.com/watch?v=AdtiVFwlXdw&w=560&h=315
