class EventsController < ApplicationController
	def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(params.require(:event).permit(:title, :description, :start_date, :end_date))
		@event.save
		redirect_to '/events'
	end

end
