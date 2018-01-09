require "pry"
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
		#binding.pry

	end

	def more_info
		puts "#{self.name}"
		puts "Address: #{self.address}"
		puts "Phone Number: #{self.phone_number}"
		puts "Website: #{self.website}"
	end

	def self.theater_info
		self.all.each do |theater|
			puts "#{theater.name}"
			puts "Address: #{theater.address}"
			puts "Phone Number: #{theater.phone_number}"
			puts "Website: #{theater.website}"
			puts "#{movie_titles.join(", ")}"
		end
	end

	def movie_titles
		@movies.collect do |movie|
			movie.title
		end
	end

	def showtimes
		self.movies.each do |movie|
			#binding.pry
			puts "#{movie[0]}".colorize(:dark_blue)
			puts "	#{movie[1][:showtimes]}".colorize(:light_blue)
		end
	end
end