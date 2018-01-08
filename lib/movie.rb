require "pry"
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
		self.all.each_with_index do |movie, i|
			puts "#{i+1}. #{movie.title}"
			cinemark = movie.theaters.find{|theater| theater.chain == :cinemark}
			if cinemark == nil
				cinemark_movie_showtimes = "No showings at this theater."
			else
				cinemark_movie_showtimes = cinemark.movies["#{movie.title}"][:showtimes]
			end
			
			regal = movie.theaters.find{|theater| theater.chain == :regal}
			if regal == nil
				regal_movie_showtimes = "No showings at this theater"
			else
				regal_movie_showtimes = regal.movies["#{movie.title}"][:showtimes]
			end
			puts "Cinemark: #{cinemark_movie_showtimes}"
			puts "Regal: #{regal_movie_showtimes}"
		end
	end

	def more_info
		puts "#{self.title}"
		puts "Rating: #{self.rating}"
		puts "Length: #{self.length}"
		puts "Cinemark Times: #{self.cinemark}"
		puts "Regal Times: #{self.regal}"
	end
end




			#:cinemark => {
			#	:show_times => "",
			#	:theater_object => movie_hash[:theater_object]
			#},
			#:regal => {
			#	:show_times => "",
			#	:theater_object => ""
			#}

#theater.movie[:show_times] = movie_hash[:show_times]