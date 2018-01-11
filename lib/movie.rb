class Movie
	attr_accessor :title, :rating, :length, :theaters
	@@all = []
	def initialize(movie_hash)
		movie_hash.each do |key, value| 
			if key != :showtimes && key != :theater
				self.send(("#{key}="), value)
			end
		end
		@theaters = []
		self.add_additional_attributes(movie_hash)
		@@all << self
	end

	def self.create_from_scraper(movie_array)
		movie_array.each do |movie_hash|
			current_movies_in_all = self.all.collect do |movie|
				movie.title
			end
			if current_movies_in_all.include?(movie_hash[:title])
				movie_in_all = self.all.find do |movie|
					movie.title == movie_hash[:title]
				end
				movie_in_all.add_additional_attributes(movie_hash)

			else
				Movie.new(movie_hash)
			end
		end
		
	end

	def self.all
		@@all
	end

	def add_additional_attributes(movie_hash)
		if @theaters.include?(movie_hash[:theater])
			theater = @theaters.find{|theater| theater.name == movie_hash[:theater][:name]}
			theater.add_movie_with_showtimes(self, movie_hash[:showtimes])
		else
			theater = movie_hash[:theater]
			@theaters << theater
			theater.add_movie_with_showtimes(self, movie_hash[:showtimes])
		end
		self
	end

	def self.show_times
		colors_for_theaters = []
		Theater.all.count.times do 
			colors_for_theaters << String.colors.sample
		end
		self.all.each_with_index do |movie, i|
			puts "#{i+1}. #{movie.title}".colorize(:blue)
			movie.theaters.each_with_index do |theater, i|
				showtimes = theater.movies["#{movie.title}"][:showtimes]
				puts "	#{theater.name}: #{showtimes}".colorize(colors_for_theaters[i])
			end
			puts "----------------------------------------".colorize(:black)
		end
	end


end

