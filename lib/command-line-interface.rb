require_relative "./movie.rb"
require_relative "./theater.rb"
require_relative "./regal_scraper.rb"
require_relative "./cinemark_scraper.rb"


Cinemark_scraper.scrape_theater("https://www.cinemark.com/utah/cinemark-sugar-house")
Cinemark_scraper.scrape_movies("https://www.cinemark.com/utah/cinemark-sugar-house")

Regal_scraper.scrape_theater("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")
Regal_scraper.scrape_movies("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")