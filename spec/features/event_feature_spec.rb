require 'rails_helper'

describe 'event' do 
	context 'initial setup' do 
		it 'without events' do 
			visit '/events'
			expect(page).to have_content 'No Events Yet Please Help'
		end
	end
end

