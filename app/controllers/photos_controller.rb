class PhotosController < ApplicationController

	def new
		find_event
		@photo = Photo.new
	end

	def create
		find_event
		new_photo_with_permissions  
		set_foody
		flash[:notice] = 'Photo created!'
		redirect_to event_path(@event)
	end

	private

	def find_event
		@event = Event.find params[:event_id]
	end

	def new_photo_with_permissions
		@photo = @event.photos.new params[:photo].permit(:caption, :rating, :photo)
	end

	def set_foody
		@photo.foody = current_foody
		@photo.save!
	end
end
