require 'rails_helper'

RSpec.describe Event, :type => :model do

	before do 
	  	@event = Event.create(title: 'test event', description: 'test description', address: 'Freegrove Road', city: 'London', postcode: 'N7 9JN', 
			start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
	end

	it 'returns a fully formed address line' do
		expect(@event.complete_address).to eq 'Freegrove Road, London, N7 9JN'
	end

	it 'returns the latitude of the address' do 
		expect(@event.lat).to eq 51.5511925
	end

	it 'returns the longitude of the address' do 
		expect(@event.lng).to eq -0.12177
	end	

end
