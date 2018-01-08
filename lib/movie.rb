class Movie
	attr_accessor :title, :rating, :carmike, :megaplex

	@@all = []
	def initialize(title)
		@title = title
		@@all << self
	end

	def self.create_from_scraper(movie_object)
		movie_object.each do |key, value|
			self.send(("#{key}="), value)
		end
	end

	def self.all
		@@all
	end

end