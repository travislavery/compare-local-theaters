require "pry"
require_relative "./movie.rb"
require_relative "./theater.rb"
require_relative "./regal_scraper.rb"
require_relative "./cinemark_scraper.rb"


cinemark_movies = Cinemark_scraper.scrape_movies("https://www.cinemark.com/utah/cinemark-sugar-house")

regal_movies = Regal_scraper.scrape_movies("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")


Movie.create_from_scraper(regal_movies)
Movie.create_from_scraper(cinemark_movies)

#binding.pry
Movie.show_times

#cinemark.movies
#cinemark.movie_titles


#### SHOULDN'T BE NEEDED ####
#regal_theater = Regal_scraper.scrape_theater("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")
#cinemark_theater = Cinemark_scraper.scrape_theater("https://www.cinemark.com/utah/cinemark-sugar-house")
#cinemark = Theater.create_from_scraper(cinemark_theater)
#regal = Theater.create_from_scraper(regal_theater)
