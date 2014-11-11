class EventsController < ApplicationController

	before_action :authenticate_foody!, except: [:index]

	def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(params.require(:event).permit(:title, :description, :start_date, :end_date, :address, :city, :postcode, :image))
		@event.foody_id = current_foody.id
		@event.save
		redirect_to '/events'
	end

end
