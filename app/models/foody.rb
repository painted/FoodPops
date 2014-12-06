class Foody < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  has_many :reviews
  has_many :photos
  has_attached_file :avatar,
	:default_url => "/images/original/missing.png",
	styles: { thumb: '300X300#' },
	storage: :s3,
	:s3_protocol => :https,
	s3_credentials: {
		bucket: 'foodups',
		access_key_id: Rails.application.secrets.s3_access_key,
		secret_access_key: Rails.application.secrets.s3_secret_key
	}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
