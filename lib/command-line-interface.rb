require "pry"
require_relative "./movie.rb"
require_relative "./theater.rb"
require_relative "./regal_scraper.rb"
require_relative "./cinemark_scraper.rb"

class CommandLineInterface
	attr_accessor :keep_viewing

	def initialize(*args)
		@keep_viewing = true
		args.each do |arg|
			Movie.create_from_scraper(arg)
			#binding.pry
		end
	end
	def start
		puts "Welcome to Compare Local Theaters!"
		main_menu
	end

	def main_menu
		puts "Main Menu"
		puts "We have #{Theater.all.count} theaters on file:"
		Theater.all.each do |theater|
			puts "#{theater.name}"
		end
		puts "Would you like to \n
		(1) View today's showtimes\n
		(2) See more information about the theaters"
		continue = true
		while continue
			user_input = gets.strip
			if user_input == "1"
				continue = false
				movie_commands
			elsif user_input == "2"
				
				continue = false
				theater_commands
			else
				puts "Invalid entry"
			end
		end
	end

	def movie_commands
		continue = true
		Movie.show_times
		puts "To view more information about a movie, enter it's number."
		puts "Type 'main' to return to the main menu"
		puts "Type 'exit' to exit the application"
		while continue 
			user_input = check_input("movie")
			Movie.all[user_input].more_info
		end

	end

	def theater_commands
		Theater.theater_info
		puts "To view a specific theater's movies, enter it's number."
		puts "Type 'main' to return to the main menu"
		puts "Type 'exit' to exit the application"
		while self.keep_viewing
			user_input = check_input("theater")
			Theater.all[user_input].showtimes
		end
	end

	def check_input(type)
		continue = true
		while continue
			input = gets.strip
			if input.downcase == 'main'
				main_menu
			elsif input.downcase == 'exit'
				exit 1
			else
				if type == "movie"
					if input.to_i > 0 && input.to_i <= Movie.all.count+1
						continue = false
						return input.to_i
					else
						puts "Invalid entry"
					end
				elsif type == "theater"
					if input.to_i > 0 && input.to_i <= Theater.all.count+1
						continue = false
						return input.to_i
					else 
						puts "Invalid entry"
					end
				end
			end
		end
	end
end



		#Movie.create_from_scraper(regal_movies)
		#Movie.create_from_scraper(cinemark_movies)










#
#Theater.all[0].showtimes
#binding.pry
#Movie.show_times

#cinemark.movies
#cinemark.movie_titles


#### SHOULDN'T BE NEEDED ####
#regal_theater = Regal_scraper.scrape_theater("https://www.regmovies.com/theaters/regal-crossroad-14-rpx/c00662716661")
#cinemark_theater = Cinemark_scraper.scrape_theater("https://www.cinemark.com/utah/cinemark-sugar-house")
#cinemark = Theater.create_from_scraper(cinemark_theater)
#regal = Theater.create_from_scraper(regal_theater)
