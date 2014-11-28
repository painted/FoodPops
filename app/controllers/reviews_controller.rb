class ReviewsController < ApplicationController
	def new
		@event = Event.find params[:event_id]
		@review = Review.new
	end
end
