class Event < ActiveRecord::Base
	def complete_address
		"#{self.address}, #{self.city}, #{self.postcode}"
	end
end
