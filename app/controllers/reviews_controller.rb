class ReviewsController < ApplicationController

	def new
		@event = Event.find params[:event_id]
		@review = Review.new
	end

	def create
		@event = Event.find params[:event_id]
		@review = @event.reviews.new params[:review].permit(:thoughts, :rating)
		# This next line is not working
		# I want to be able to have the notice if a foody has created a review
		# for this event within 1 day
		if @event.reviews.where("foody_id = ? && created_at <= ?", current_foody.id, Time.now - 1.day)
			flash[:notice] = 'Unfortunately, you have met your daily limit of reviews for this event.'
		else
			@review.foody = current_foody
			@review.save!
			flash[:notice] = 'Review created!'
		end
		redirect_to event_path(@event)
	end
end
