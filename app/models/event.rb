class Event < ActiveRecord::Base

	geocoded_by :complete_address, :latitude  => :lat, :longitude => :lng   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates
	belongs_to :foody
	has_attached_file :image, :default_url => "/images/original/missing.png", styles: { thirtythree: '480X360>', sixtysix: '960X360>' }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	
	def complete_address
		"#{self.address}, #{self.city}, #{self.postcode}"
	end

end
