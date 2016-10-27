### Exercise 2 ###

# As you noticed, it often takes multiple queries to retrieve the desired information.
# This is a perfect situation in which writing a function will allow you to better structure your
# code, and give a name to a repeated task.
library(jsonlite)
setwd("~/info201/m10-apis/exercise-2")
# Write a function that allows you to specify an artist, and returns the top 10 tracks of that artist
GetTopTen <- function(artist.name){
  base = 'https://api.spotify.com/v1/'
  artist.id = fromJSON(paste0(base, 'search?', 'q=', artist.name, '&type=artist'))$artists$items$id[1]
  top.tracks.url = paste0(base, 'artists/', artist.id, '/top-tracks?country=US')
  top.tracks.spotify.objects <- fromJSON(top.tracks.url)
  tracks.object.list <- paste0(c(top.tracks.spotify.objects$tracks$id), collapse=',')
  json.url = paste0(base, 'tracks?ids=', tracks.object.list)
  top.tracks.info <- fromJSON(json.url)
  return(top.tracks.info)
}


# What are the top 10 tracks by Nelly?
top.10.tracks.nelly <- GetTopTen("Nelly")



### Bonus ### 
# Write a function that allows you to specify a search type (artist, album, etc.), and a string, 
# that returns the album/artist/etc. page of interest

SearchSpotify <- function(search.type, search.query){
  base = 'https://api.spotify.com/v1/'
  json.url = paste0(base, 'search?', 'q=', search.query, '&type=', search.type)
  print(json.url)
  print('https://api.spotify.com/v1/search?q=Sermon&type=album')
  data <- fromJSON(json.url)
  return(data)
}
# Search albums with the word "Sermon"
data <- SearchSpotify("album", "Sermon")
