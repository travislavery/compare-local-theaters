class Movie
	attr_accessor :title, :rating, :length, :show_times, :carmike, :regal

	@@all = []
	def initialize(movie_hash)
		movie_hash.each {|key, value| self.send(("#{key}="), value)}
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

end