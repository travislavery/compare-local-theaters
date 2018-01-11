class Cinemark_scraper

	def self.scrape_theater(url)
		html = open(url)
		doc = Nokogiri::HTML(html)

		theater_info = doc.css("#xsTheatreInfo .theatreInfoCollapseBody p")

		{
			:website => url,
			:chain => :cinemark,
			:name => "Cinemark Sugar House",
			:address => theater_info.text.split(/\r\n\s+/)[1].split(/\s+/).join(" "),
			:phone_number => theater_info.text.split(/\r\n\s+/)[2]
		}
	end

	def self.scrape_movies(url)
		html = open(url)
		doc = Nokogiri::HTML(html)

		movies = doc.css(".showtimeMovie")

		theater = Theater.create_from_scraper(Cinemark_scraper.scrape_theater(url))
		movies.collect do |movie|
			showtimes_array = movie.css(".showtimeMovieTimes .showtime").collect do |m|
				m.text.split(/\r*\n*\s+/)[1]
			end
			{
				:theater => theater,
				:title => movie.css("h2").text,
				:showtimes => showtimes_array.join(" "),
				:rating => movie.css(".showtimeMovieRating").text,
				:length => movie.css(".showtimeMovieRuntime").text
			}
		end		
	end
end


