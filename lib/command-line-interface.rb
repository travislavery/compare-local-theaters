require "colorize"
require_relative "./movie.rb"
require_relative "./theater.rb"
require_relative "./scrapers/regal_scraper.rb"
require_relative "./scrapers/cinemark_scraper.rb"

class CommandLineInterface
	attr_accessor :keep_viewing, :current_theater

	def initialize(*args)
		@keep_viewing = true
		args.each do |arg|
			Movie.create_from_scraper(arg)
		end
	end

	def start
		puts "	Welcome to Compare Local Theaters!"
		puts "----------------------------------------------"
		main_menu
	end

	def main_menu
		puts "\nMain Menu".colorize(:green)
		puts "\nWe have #{Theater.all.count} theaters on file:"
		Theater.all.each do |theater|
			puts "#{theater.name}"
		end
		puts "\nWould you like to"
		puts "(1) View today's showtimes"
		puts "(2) See more information about the theaters\n"

		while self.keep_viewing
			user_input = gets.strip
			if user_input == "1"
				movie_commands('all')
			elsif user_input == "2"
				theater_commands
			else
				puts "Invalid entry"
			end
		end
	end

	def movie_commands(specify)
		if specify == "all"
			Movie.show_times
			CommandLineInterface.instructions
			while self.keep_viewing
				user_input = check_input("movie")
				Movie.all[user_input].more_info
			end
		elsif specify == "single"
			@current_theater.showtimes
			CommandLineInterface.instructions
			while self.keep_viewing
				user_input = check_input("movie")
				@current_theater.movie_by_input(user_input).more_info
			end
		end
	end

	def theater_commands
		Theater.theater_info
		puts "----------------------------------------------------------".colorize(:white)
		number = "number".colorize(:red)
		puts "Type a theater's '#{number}' to view more information about it."
		main = "main".colorize(:red)
		puts "Type '#{main}' to return to the main menu"
		exit_colored = "exit".colorize(:red)
		puts "Type '#{exit_colored}' to exit the application"
		puts "----------------------------------------------------------".colorize(:white)
		while self.keep_viewing
			user_input = check_input("theater")
			@current_theater = Theater.all[user_input]
			movie_commands('single')
		end
	end

	def check_input(type)
		while self.keep_viewing
			input = gets.strip
			if input.downcase == 'main'
				main_menu
			elsif input.downcase == 'exit'
				exit 1
			else
				if type == "movie"
					if input.to_i > 0 && input.to_i <= Movie.all.count+1
						return input.to_i - 1
					else
						puts "Invalid entry"
					end
				elsif type == "theater"
					if input.to_i > 0 && input.to_i <= Theater.all.count+1
						return input.to_i - 1
					else 
						puts "Invalid entry"
					end
				end
			end
		end
	end

	def self.instructions
		puts "----------------------------------------------------------".colorize(:white)
		number = "number".colorize(:red)
		puts "Type a movie's '#{number}' to view more information about it."
		main = "main".colorize(:red)
		puts "Type '#{main}' to return to the main menu"
		exit_colored = "exit".colorize(:red)
		puts "Type '#{exit_colored}' to exit the application"
		puts "----------------------------------------------------------".colorize(:white)
	end
end