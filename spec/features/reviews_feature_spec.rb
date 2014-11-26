require 'rails_helper'

def leave_review(thoughts, rating)
	visit events_path
	fill_in 'Write a review:', with: thoughts
	select rating, from: 'Rating'
	click_button 'Create Review'
end

describe 'writing reviews' do 
	before do 
		bob = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
		bob.events.create(title: 'test event', description: 'test description', 
		start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00")) 
		login_as bob
	end

	it 'should add the review to the event' do 
		leave_review('Aweful', 2)
		expect(page).to have_content 'Aweful (★★☆☆☆)'
	end
end

describe 'average ratings' do
	before do 
		bob = Foody.create email: 'b@b.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
		sam = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'sam'
		bob.events.create(title: 'test event', description: 'test description', 
		start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00")) 
		login_as bob
	end

	it 'should find the average rating 3' do 
		leave_review('Bad', 2)
		login_as sam
		leave_review('Good', 4)

		expect(page).to have_content '★★★☆☆ Average rating'
	end
end