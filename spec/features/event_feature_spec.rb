require 'rails_helper'

describe 'event' do 
	context 'initial setup' do 
		it 'without events' do 
			visit '/events'
			expect(page).to have_content 'No Events Yet Please Help'
		end

		it 'with one event' do
			Event.create(title: 'test event', description: 'test description', 
				start_date: Time.new(2014, 11, 05, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 07, 14, 0, 0, "+00:00"))
			visit '/events'
			expect(page).to have_content 'test event - test description goes from 2014-11-05 12:00:00 UTC to 2014-11-07 14:00:00 UTC'
		end
	end
end