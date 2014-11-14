require 'rails_helper'

describe 'event' do 
	context 'initial setup' do 
		it 'without events' do 
			visit '/events'
			expect(page).to have_content 'No Events Yet Please Help'
		end

		it 'with one event' do
			bob = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
			bob.events.create(title: 'test event', description: 'test description', 
				start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
			visit '/events'
			expect(page).to have_content 'test event'
			expect(page).to have_content 'test description'
			expect(page).to have_content 'goes from 2014-11-05 12:00:00 UTC to 2014-11-07 14:00:00 UTC'
		end
	end

	context 'logged in' do
		
		before do  
			bob = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
			login_as bob
			create_event
		end

		context 'addition by form' do 
			it 'includes title, description, start_date and end_date' do 
				expect(page).to have_content 'Event 1'
				expect(page).to have_content 'Really Cool Event'
				expect(page).to have_content 'goes from 2014-11-10 12:00:00 UTC to 2015-12-11 14:01:00 UTC'
			end

			it 'includes the address of the event.' do
				expect(page).to have_content 'Freegrove Road - London - N7 9JN'
			end

			it 'includes the username of the foody that created the event.' do
				expect(page).to have_content 'posted by bob.'
			end

			it 'can add a photo to our events' do
				expect(current_path).to eq events_path
				expect(page).to have_content 'Event 1'
				expect(page).to have_css 'img.uploaded-pic'
			end
		end

		context 'event page' do 
			it 'shows a single event' do 
				within '.image-link' do 
					find('a', 'uploaded-pic').click
				end
				expect(current_path).to eq event_path(Event.last)
				expect(page).to have_content 'Event 1'
			end
		end

	end

	context 'logged out' do
		it 'should forward user to sign in page' do
			visit '/events'
			click_link 'Create event'
			expect(page).to have_content 'Sign in'
		end
	end
end
