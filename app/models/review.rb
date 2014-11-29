class Review < ActiveRecord::Base
	belongs_to :event
	belongs_to :foody
end
