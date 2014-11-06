require 'rails_helper'

RSpec.describe Event, :type => :model do
  it 'returns a fully formed address line' do
  	event = Event.create(title: 'test event', description: 'test description', address: 'Freegrove Road', city: 'London', postcode: 'N7 9JN', 
				start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
  	expect(event.complete_address).to eq 'Freegrove Road, London, N7 9JN'
  end
end
