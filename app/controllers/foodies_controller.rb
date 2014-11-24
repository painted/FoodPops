class FoodiesController < ApplicationController

	def index
		@users = Foody.all
	end

end