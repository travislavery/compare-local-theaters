require "nokogiri"
require "pry"
require "open-uri"

class Cinemark_scraper


	def self.scrape_theater(url)
		#"https://www.cinemark.com/utah/cinemark-sugar-house"
		html = open(url)
		doc = Nokogiri::HTML(html)

		theater_info = doc.css("#xsTheatreInfo .theatreInfoCollapseBody p")

		theater = {
			:website => url,
			:chain => "cinemark",
			:name => "Cinemark Sugar House",
			:address => theater_info.text.split(/\r\n\s+/)[1].split(/\s+/).join(" "),
			:phone_number => theater_info.text.split(/\r\n\s+/)[2]
		}
		puts "#{theater}"
		

	end

	def self.scrape_movies(url)
		html = open(url)
		doc = Nokogiri::HTML(html)

		movies = doc.css(".showtimeMovie")


		output = movies.collect do |movie|
			showtimes_array = movie.css(".showtimeMovieTimes .showtime").collect do |m|
				m.text.split(/\r*\n*\s+/)[1]
			end
			{
				:title => movie.css("h2").text,
				:show_times => showtimes_array.join(" "),
				:rating => movie.css(".showtimeMovieRating").text,
				:length => movie.css(".showtimeMovieRuntime").text
			}
			#binding.pry
		end
		puts "#{output}"
		
	end
end

Cinemark_scraper.scrape_theater("https://www.cinemark.com/utah/cinemark-sugar-house")
Cinemark_scraper.scrape_movies("https://www.cinemark.com/utah/cinemark-sugar-house")
