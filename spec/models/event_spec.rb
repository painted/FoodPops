require 'rails_helper'

RSpec.describe Event, :type => :model do

	describe '#complete_address' do 
		before do 
		  	@event = Event.create(title: 'test event', description: 'test description', address: '10 Freegrove Road', city: 'London', postcode: 'N7 9JN', 
				start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
		end

		it 'returns a fully formed address line' do
			expect(@event.complete_address).to eq '10 Freegrove Road, London, N7 9JN'
		end

		it 'returns the latitude of the address' do 
			expect(@event.lat).to eq 51.5510216
		end

		it 'returns the longitude of the address' do 
			expect(@event.lng).to eq -0.1220339
		end	
	end

	describe '#average_rating' do 
		let(:burgermonday) { Event.create title: 'test event', description: 'test description', 
			start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00")}

		context 'with 1 review' do 
			it 'returns the rating of that review' do 
				burgermonday.reviews.create(rating: 5)
				expect(burgermonday.average_rating).to eq 5
			end
		end

		context 'with 2 reviews' do 
			it 'returns the average of the reviews' do 
				burgermonday.reviews.create(rating: 5)
				burgermonday.reviews.create(rating: 3)
				expect(burgermonday.average_rating).to eq 4
			end
		end
	end

end
