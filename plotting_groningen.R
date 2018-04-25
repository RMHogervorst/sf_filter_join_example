### needed packages
library(sf)
library(ggplot2) # you need the developmental version of ggplot2
# use devtools (install if necessary)
# use install_github("tidyverse/ggplot2")
library(dplyr)


## I assume you have the data in the folder data
# I downloaded the shapefile from the website https://gadm.org/download_country.html
# This was a zip that I extracted into the datafolder. 
# The datafolder now contains .shp, .csv, .dbf and other files.
NLD_02 <- st_read("data/NLD_adm2.shp") # municipalities
NLD_01 <- st_read("data/NLD_adm1.shp") # provinces only

## I only want Friesland?
Friesland <- filter(NLD_01, NAME_1 == "Friesland")

ggplot(Friesland)+ geom_sf()


## I want only the municipalities in Groningen?
Groningen <- filter(NLD_02, NAME_1 == "Groningen")

ggplot(Groningen)+ geom_sf() 

## But what if I want to color a tile in that province based on other information?
## join that other information to the set and plot that.

# Here I make a toyset, because I don't have other information
muni_data <- Groningen %>% 
    select(NAME_2) %>% 
    st_set_geometry(NULL) %>% 
    mutate(number_of_unicorns = runif(25, min = 10, max = 50))

# join the datasets
joined_data_groningen <- left_join(Groningen, muni_data, by = "NAME_2") 

ggplot(joined_data_groningen) +
    geom_sf(aes(fill = number_of_unicorns))
