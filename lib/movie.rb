class Movie
	attr_accessor :title, :rating, :length, :carmike, :regal
	@@all = []
	def initialize(movie_hash)
		@@all.each do |movie|
			if movie.title == movie_hash[:title]

			else
		end
			@@all.include?(movie_hash[:title])

		end
		movie_hash.each do |key, value| 
			self.send(("#{key}="), value)
		end
		@@all << self
	end

	def self.create_from_scraper(movie_array)
		movie_array.each do |movie|
			Movie.new(movie)
		end
	end

	def self.all
		@@all
	end

	def add_additional_attributes(movie_hash)
		if movie_hash[:chain] == "carmike"
			@carmike
	end
	def show_times
		@show_times = {
			:carmike => [],
			:regal => []
		}
	end
end