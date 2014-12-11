require 'rails_helper'

describe 'maps' do

	context 'events with addresses' do

		create_bob
		create_bobs_event

		it 'displays a map (needs internet)', js:true do
			visit '/events/8'
			expect(page).to have_css '.gm-style'
		end
	end
end