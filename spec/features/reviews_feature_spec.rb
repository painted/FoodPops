require 'rails_helper'

def leave_review(thoughts, rating)
	click_link 'Write a review' 
	fill_in 'Review', with: thoughts
	select rating, from: 'Rating'
	click_button 'Submit Review'
end

describe 'reviews' do 

	context 'creation' do 

		before do 
			@bob = Foody.create email: 'b@b.com', password: '12345678', password_confirmation: '12345678', username: 'Bob'
			@bob.events.create(title: 'test event', description: 'test description', 
			start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00")) 
			login_as @bob
		end

		it 'should add the review to the event' do 
			visit '/events/1'
			leave_review('Aweful', 2)
			expect(page).to have_content 'Aweful (★★☆☆☆)'
		end

		it 'should add the review creator username to the review' do 
			visit '/events/2'
			leave_review('Excellent', 6)
			expect(page).to have_content 'Excellent (★★★★★★)'
			expect(page).to have_content 'Review by Bob'
		end

		context 'users limits' do 

			it 'only 1 per day' do 
				@bob.events.last.reviews.create thoughts: 'The Best', rating: '6', created_at: Time.now.ago(60 * 60 * 20), foody_id: @bob.id
				visit '/events/3'
				leave_review('No better', 6)
				expect(page).to have_content 'Unfortunately, you have met your daily limit of reviews for this event.'
			end

			it 'only 5 per month' do 
				@bob.events.last.reviews.create thoughts: 'The Best', rating: '6', created_at: 2.days.ago, foody_id: @bob.id
				@bob.events.last.reviews.create thoughts: 'The Best', rating: '6', created_at: 6.days.ago, foody_id: @bob.id
				@bob.events.last.reviews.create thoughts: 'The Best', rating: '6', created_at: 8.days.ago, foody_id: @bob.id
				@bob.events.last.reviews.create thoughts: 'The Best', rating: '6', created_at: 12.days.ago, foody_id: @bob.id
				@bob.events.last.reviews.create thoughts: 'The Best', rating: '6', created_at: 20.days.ago, foody_id: @bob.id
				visit '/events/4'
				leave_review('No better', 6)
				expect(page).to have_content 'Unfortunately, you have met your monthly limit of reviews for this event.'
			end
		end

	end

	context 'average' do

		before do 
			@bob = Foody.create email: 'b@b.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
			sam = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'sam'
			@bob.events.create(title: 'test event', description: 'test description', 
			start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00")) 
			login_as @bob 
		end

		it 'should find the average rating of 2 reviews with count' do 
			@bob.events.last.reviews.create thoughts: 'Not great', rating: '2', created_at: Time.now.ago(60 * 60 * 60), foody_id: @bob.id
			visit '/events/5o-'
			leave_review('Good', 4)

			expect(page).to have_content '★★★☆☆ (2)'
		end

	end
end