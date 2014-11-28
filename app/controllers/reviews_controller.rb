class ReviewsController < ApplicationController

	def new
		@event = Event.find params[:event_id]
		@review = Review.new
	end

	def create
		@event = Event.find params[:event_id]
		@review = @event.reviews.create params[:review].permit(:thoughts, :rating)
		flash[:notice] = 'Review created!'
		redirect_to event_path(@event)
	end
end
