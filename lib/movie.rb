require "pry"

class Movie
	attr_accessor :title, :rating, :length, :cinemark, :regal
	@@all = []
	def initialize(movie_hash)
		movie_hash.each do |key, value| 
			if key != :chain && key != :show_times
				self.send(("#{key}="), value)
			end
		end
		add_additional_attributes(self, movie_hash)
		@@all << self
	end

	def self.create_from_scraper(movie_array)
		movie_array.each do |movie_hash|
			
			current_movies_in_all = self.all.collect do |movie|
				movie.title
			end
			if current_movies_in_all.include?(movie_hash[:title])
				movie_in_all = self.all.search do |movie|
					movie.title == movie_hash[:title]
				end
				add_additional_attributes(movie_in_all, movie_hash)
			else
				Movie.new(movie_hash)
			end
			
		end
		#binding.pry
		
	end

	def self.all
		@@all
	end

	def add_additional_attributes(movie, movie_hash)
		if movie_hash[:chain] == "cinemark"
			movie.cinemark = movie_hash[:show_times]
		elsif movie_hash[:chain] == "regal"
			movie.regal = movie_hash[:show_times]
		end
	end

	def self.show_times
		self.all.each_with_index do |movie, i|
			puts "#{i+1}. #{movie.title}"
			puts "Carmike: #{movie.cinemark}"
			puts "Regal: #{movie.regal}"
		end
	end
end