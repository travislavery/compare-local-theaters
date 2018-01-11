class Theater
	attr_accessor :name, :address, :phone_number, :movies, :chain, :website
	@@all = []
	def initialize
		@@all << self
		@movies = {}
	end

	def self.create_from_scraper(theater_hash)
		theater = self.new
		theater_hash.each do |key, value|
			theater.send(("#{key}="), value)
		end
		theater
	end

	def self.all
		@@all
	end

	def add_movie_with_showtimes(movie, showtimes)

		@movies["#{movie.title}"] = {
			:movie => movie,
			:showtimes => showtimes
		}
	end

	def movie_titles
		self.movies.collect do |movie|
			movie[0]
		end
	end


	def movie_by_input(input)
		movie_title = self.movie_titles[input]
		self.movies[movie_title][:movie]
	end
end