require 'rails_helper'

describe 'photos' do 
	context 'foodies logged in' do

		before do 
			@bob = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
			@bob.events.create(title: 'test event', description: 'test description', 
				start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
			login_as @bob
		end

		it 'can add a photo to an event' do
			visit '/events/7'
			click_link 'Add a photo'
			fill_in 'Caption', with: 'Test Caption'
			attach_file 'Photo', Rails.root.join('spec/images/FoodTrucks.jpg')
			click_button 'Submit Photo'
			expect(page).to have_content 'Test Caption'
			expect(page).to have_css 'img.bobsphoto'
		end
	end
end