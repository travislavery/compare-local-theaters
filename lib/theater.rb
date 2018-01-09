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
		self.all.each_with_index do |theater, i|
			puts "--------------------------------------".colorize(:white)
			puts "#{i+1}. #{theater.name}"
			puts "--------------------------------------".colorize(:white)
			puts "#{theater.address}\n".colorize(:light_blue)
			puts "#{theater.phone_number}\n".colorize(:light_blue)
			puts "#{theater.website}".colorize(:light_blue)
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

	def movie_by_input(input)
		movie_title = self.movie_titles[input]
		self.movies[movie_title][:movie]
	end
end