class FoodiesController < ApplicationController
	before_action :authenticate_foody!
	
	def index
		@users = Foody.all
	end

end