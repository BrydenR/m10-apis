### Exercise 3 ###
library(jsonlite)
library(dplyr)
# Use the `load` function to load in the nelly_tracks file.  That should make the data.frame
# `top_nelly` available to you
setwd("~/info201/m10-apis/exercise-3/")
load("nelly_tracks.Rdata")
data <- top.nelly
# Use the `flatten` function to flatten the data.frame -- note what differs!
flat.data <- flatten(data)

# Use your `dplyr` functions to get the number of the songs that appear on each album
albums.ids <- paste0(flat.data$album.id, collapse=",")
base = 'https://api.spotify.com/v1/'
album.info <- fromJSON(paste0(base, 'albums?ids=', albums.ids))
number <- nrow(album.info$albums$tracks)

# Bonus: perform both of the steps above in one line (one statement)
number <- top.nelly %>%
  flatten() %>%
  group_by(album.name) %>%
  summarise(n = n()) %>%
  arrange(-n)