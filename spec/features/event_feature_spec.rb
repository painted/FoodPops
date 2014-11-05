require 'rails_helper'

def select_date_and_time(date, options = {})
  field = options[:from]
  select date.strftime('%Y'), :from => "#{field}_1i" #year
  select date.strftime('%B'), :from => "#{field}_2i" #month
  select date.strftime('%d'), :from => "#{field}_3i" #day 
  select date.strftime('%H'), :from => "#{field}_4i" #hour
  select date.strftime('%M'), :from => "#{field}_5i" #minute
end

describe 'event' do 
	context 'initial setup' do 
		it 'without events' do 
			visit '/events'
			expect(page).to have_content 'No Events Yet Please Help'
		end

		it 'with one event' do
			Event.create(title: 'test event', description: 'test description', 
				start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
			visit '/events'
			expect(page).to have_content 'test event - test description goes from 2014-11-05 12:00:00 UTC to 2014-11-07 14:00:00 UTC'
		end
	end

	context 'addition by form' do 
		it 'includes title, description, start_date and end_date' do 
			visit 'events/new' 
			fill_in 'Title', with: 'Event 1'
			fill_in 'Description', with: 'Really Cool Event'
			select_date_and_time(Time.new(2014, 11, 10, 12, 0 ), from:'event_start_date')
			select_date_and_time(Time.new(2015, 12, 11, 14, 1 ), from:'event_end_date')
			click_button 'Submit'
			expect(page).to have_content 'Event 1 - Really Cool Event goes from 2014-11-10 12:00:00 UTC to 2015-12-11 14:01:00 UTC'
		end
	end
end