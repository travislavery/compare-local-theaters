require "nokogiri"
require "pry"
require "open-uri"

class Regal_scraper

	def self.scrape_theater(url)
		html = open(url)
		doc = Nokogiri::HTML(html)

		theater_info = doc.css(".page-header.venue")

		theater = {
			:website => url,
			:chain => "regal",
			:name => theater_info.css("h1").text,
			:address => theater_info.css(".address a").text.split(" view")[0],
			:phone_number => "None"
		}
	end

	def self.scrape_movies(url)
		html = open(url)
		doc = Nokogiri::HTML(html)

		movies = doc.css(".showtimes-container .showtime-panel")


		movies.collect do |movie|
			showtimes_array = movie.css(".format-showtimes").text.split(/\s{2,}/).collect do |m|
				m.split(/\s+/).join("").downcase
			end
			{
				:chain => "regal",
				:title => movie.css(".title a").text.split(/\s{2,}/)[1],
				:show_times => showtimes_array.sort.join(" "),
				:rating => movie.css(".list-inline title").text.split("Rated ")[1],
				:length => movie.css(".list-inline li:nth-child(2)").text
			}
		end
	end
end

