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
		puts "Movies:"
	end

	def movie_titles
		@movies.each do |movie|
			puts "#{movie.title}"
		end
	end

	def showtimes
		@movies.each do |movie|
			puts "#{movie.title}"
			puts "#{movie.theaters[self.chain][:show_times]}"
		end
	end
end