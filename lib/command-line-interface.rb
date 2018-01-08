require_relative "./movie.rb"
require_relative "./theater.rb"
require_relative "./regal_scraper.rb"
require_relative "./cinemark_scraper.rb"


cinemark_theater = Cinemark_scraper.scrape_theater("https://www.cinemark.com/utah/cinemark-sugar-house")
cinemark_movies = Cinemark_scraper.scrape_movies("https://www.cinemark.com/utah/cinemark-sugar-house")

regal_theater = Regal_scraper.scrape_theater("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")
regal_movies = Regal_scraper.scrape_movies("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")

Movie.create_from_scraper(cinemark_movies)
Movie.show_times