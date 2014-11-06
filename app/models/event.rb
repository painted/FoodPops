class Event < ActiveRecord::Base

	geocoded_by :complete_address, :latitude  => :lat, :longitude => :lng   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	def complete_address
		"#{self.address}, #{self.city}, #{self.postcode}"
	end

end
