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
		self.add_additional_attributes(movie_hash)
		@@all << self
	end

	def self.create_from_scraper(movie_array)
		movie_array.each do |movie_hash|
			current_movies_in_all = self.all.collect do |movie|
				movie.title
			end
			#binding.pry
			if current_movies_in_all.include?(movie_hash[:title])
				#binding.pry
				movie_in_all = self.all.find do |movie|
					movie.title == movie_hash[:title]
				end
				movie_in_all.add_additional_attributes(movie_hash)

			else
				Movie.new(movie_hash)
			end
			#binding.pry
			
		end
		#binding.pry
		
	end

	def self.all
		@@all
	end

	def add_additional_attributes(movie_hash)
		if movie_hash[:chain] == "cinemark"

			self.cinemark = movie_hash[:show_times]
		elsif movie_hash[:chain] == "regal"
			self.regal = movie_hash[:show_times]
		end
	end

	def self.show_times
		self.all.each_with_index do |movie, i|
			puts "#{i+1}. #{movie.title}"
			puts "Cinemark: #{movie.cinemark}"
			puts "Regal: #{movie.regal}"
		end
	end

	def more_info
		puts "#{self.title}"
		puts "Rating: #{self.rating}"
		puts "Length: #{self.length}"
		puts "Cinemark Times: #{self.cinemark}"
		puts "Regal Times: #{self.regal}"
	end

	def cinemark=(times)

		times
	end
end