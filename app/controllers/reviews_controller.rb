class ReviewsController < ApplicationController

	def new
		@event = Event.find params[:event_id]
		@review = Review.new
	end

	def create
		@event = Event.find params[:event_id]
		@review = @event.reviews.new params[:review].permit(:thoughts, :rating)
		@review.foody = current_foody
		@review.save!
		flash[:notice] = 'Review created!'
		redirect_to event_path(@event)
	end
end
