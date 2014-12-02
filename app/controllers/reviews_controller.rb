class ReviewsController < ApplicationController

	def new
		@event = Event.find params[:event_id]
		@review = Review.new
	end

	def create
		@event = Event.find params[:event_id]
		@review = @event.reviews.new params[:review].permit(:thoughts, :rating)
		@user_id = current_foody.id 
		# This next line is not working
		# I want to be able to have the notice if a foody has created a review
		# for this event within 1 day
		# Review.where("EVENT_ID = ? AND FOODY_ID = ? AND created_at < ?",3,2,1.day.ago)
		# if @event.reviews.where("foody_id = ? AND created_at != ? AND created_at >=", current_foody.id, nil, Time.now - 1.day)
		if @event.reviews.where("foody_id = ? AND created_at > ?", @user_id, 1.day.ago).present?
			# if Review.find_by(["created_at >?", 2.days.ago])
			# 	flash[:notice] = 'Unfortunately, you have met your daily limit of reviews for this event.'
			# else
			# 	@review.foody = current_foody
			# 	@review.save!
			# 	flash[:notice] = 'Review created!'
			# end
			flash[:notice] = 'Unfortunately, you have met your daily limit of reviews for this event.'
		else
			@review.foody = current_foody
			@review.save!
			flash[:notice] = 'Review created!'
		end
		redirect_to event_path(@event)
	end
end
