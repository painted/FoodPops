class EventsController < ApplicationController
	def index
		@events = Event.all
		# respond_to do |format|
  #     format.html
  #     format.json { render :json => @events }
  #   end
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(params.require(:event).permit(:title, :description, :start_date, :end_date, :address, :city, :postcode))
		@event.save
		redirect_to '/events'
	end

end
