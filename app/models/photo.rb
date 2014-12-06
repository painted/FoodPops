class Photo < ActiveRecord::Base
	belongs_to :event
	belongs_to :foody
	has_attached_file :photo,
	:default_url => "/images/original/missing.png",
	styles: { thumb: '100X100#' },
	storage: :s3,
	:s3_protocol => :https,
	s3_credentials: {
		bucket: 'foodups',
		access_key_id: Rails.application.secrets.s3_access_key,
		secret_access_key: Rails.application.secrets.s3_secret_key
	}
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
