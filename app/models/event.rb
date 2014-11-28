class Event < ActiveRecord::Base

	geocoded_by :complete_address, :latitude  => :lat, :longitude => :lng # can also be an IP address
	after_validation :geocode # auto-fetch coordinates
	belongs_to :foody
	has_many :reviews
	has_attached_file :image,
	:default_url => "/images/original/missing.png",
	styles: { thirtythree: '480X360', sixtysix: '960X720' },
	storage: :s3,
	:s3_protocol => :https,
	s3_credentials: {
		bucket: 'foodups',
		access_key_id: Rails.application.secrets.s3_access_key,
		secret_access_key: Rails.application.secrets.s3_secret_key
	} 
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	
	def complete_address
		"#{self.address}, #{self.city}, #{self.postcode}"
	end

	def average_rating
		return '' if reviews.none?
		reviews.average(:rating)
	end

end
