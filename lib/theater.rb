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
			puts "----------------------------".colorize(:white)
			puts "	#{theater.name}"
			puts "----------------------------".colorize(:white)
			puts "Address: #{theater.address}".colorize(:light_blue)
			puts "Phone Number: #{theater.phone_number}".colorize(:light_blue)
			puts "Website: #{theater.website}".colorize(:light_blue)
			#puts "Currently showing: #{theater.movie_titles.join(", ")}".colorize(:light_green)
		end
	end

	def movie_titles
		self.movies.collect do |movie|
			movie[0]
		end
	end

	def showtimes
		self.movies.each_with_index do |movie, i|
			#binding.pry
			puts "#{i+1}. #{movie[0]}".colorize(:dark_blue)
			puts "	#{movie[1][:showtimes]}".colorize(:light_blue)
		end
	end
end