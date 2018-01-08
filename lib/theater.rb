class Theater
	attr_accessor :name, :address, :phone_number, :movies, :chain, :website
	@@all = []
	def initialize(name)
		@name = name
		@@all << self
	end

	def self.create_from_scraper(theater_object)
		theater_object.each do |key, value|
			self.send(("#{key}="), value)
		end
	end

	def self.all
		@@all
	end
end