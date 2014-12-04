class ReviewsController < ApplicationController

	def new
		find_event
		@review = Review.new
	end

	def create
		find_event
		new_review_with_permitions
		@user_id = current_foody.id 
		if foody_review_today?
			flash[:notice] = 'Unfortunately, you have met your daily limit of reviews for this event.'
		elsif foody_reviews_this_month == 5
			flash[:notice] = 'Unfortunately, you have met your monthly limit of reviews for this event.'
		else 
			set_foody
			flash[:notice] = 'Review created!'
		end
		redirect_to event_path(@event)
	end

	private

	def find_event
		@event = Event.find params[:event_id]
	end

	def foody_review_today?
		@event.reviews.where("foody_id = ? AND created_at > ?", @user_id, 1.day.ago).present?
	end

	def foody_reviews_this_month
		@event.reviews.where("foody_id = ? AND created_at > ?", @user_id, 31.days.ago).count
	end

	def set_foody
		@review.foody = current_foody
		@review.save!
	end

	def new_review_with_permitions
		@review = @event.reviews.new params[:review].permit(:thoughts, :rating)
	end

end

