require 'rails_helper'

describe 'photos' do 
	context 'foodies logged in' do

		create_bob
		create_bobs_event

		it 'can add a photo to an event' do
			login_as bob
			visit "/events/#{event.id}"
			click_link 'Add a photo'
			fill_in 'Caption', with: 'Test Caption'
			attach_file 'Photo', Rails.root.join('spec/images/FoodTrucks.jpg')
			click_button 'Submit Photo'
			expect(page).to have_content 'Test Caption'
			expect(page).to have_css 'img.Bobsphoto'
		end
	end
end