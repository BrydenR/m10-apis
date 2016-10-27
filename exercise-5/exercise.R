### Exercise 5 ###
library(jsonlite)
library(dplyr)

# Write a function that allows you to specify a movie, then does the following:
GetMovie <- function(movie.name){
  # Replace all of the spaces in your movie title with plus signs (+)
  movie.no.spaces = gsub(' ','+',movie.name)
  
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  api.key = '85916f88ccfd40d084d1fb874594743a'
  base.url = 'https://api.nytimes.com/svc/movies/v2/reviews/search.json'
  query = paste0(base.url,'?api-key=',api.key,'&query=',movie.no.spaces)
  print(query)

  # Request data using your search query
  movie.data <- fromJSON(query)
  
  # What type of variable does this return?
  print(typeof(movie.data))
  # Flatten the data stored in the `$results` key of the data returned to you
  flattened.movie.data <- flatten(as.data.frame(movie.data$results))
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  filtered.movie.data = flattened.movie.data %>%
    filter(publication_date == max(publication_date)) %>%
    select(headline, summary_short, link.url)
  # Return an list of the three pieces of information from above
  return(list(filtered.movie.data))
}

# Test that your function works with a movie of your choice
data <- GetMovie("The Thing")
