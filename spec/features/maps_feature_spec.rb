require 'rails_helper'

describe 'maps' do

	context 'events with addresses' do

		before do
			@bob = Foody.create(email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob')
			@bob.events.create(title: 'Cool Event', description: 'Hello world', address: '25 City Road', city: 'London', postcode: 'EC1V 2QH')
		end

		it 'displays a map (needs internet)', js:true do
			visit '/events/8'
			expect(page).to have_css '.gm-style'
		end
	end
end