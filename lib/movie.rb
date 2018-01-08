class Movie
	attr_accessor :title, :rating, :length, :carmike, :regal
	@@all = []
	def initialize(movie_hash)
		movie_hash.each do |key, value| 
			self.send(("#{key}="), value)
		end
		@@all << self
	end

	def self.create_from_scraper(movie_array)
		movie_array.each do |movie_hash|
			@@all.each do |movie_in_all|
				if movie_in_all.title == movie_hash[:title]
					add_additional_attributes(movie_in_all, movie_hash)
				else
					Movie.new(movie)
				end
			end
		end
	end

	def self.all
		@@all
	end

	def add_additional_attributes(movie, movie_hash)
		if movie_hash[:chain] == "carmike"
			movie.carmike = movie_hash[:show_times]
		elsif movie_hash[:chain] == "regal"
			movie.regal = movie_hash[:show_times]
		end
	end
	def show_times
		@show_times = {
			:carmike => [],
			:regal => []
		}
	end
end