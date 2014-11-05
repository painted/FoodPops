require 'rails_helper'

describe 'maps' do

    context 'events with addresses' do

        before do 
        
        Event.create(title: 'Cool Event', description: 'Hello world', address: '25 City Road', city: 'London', postcode: 'EC1V 2QH') 

        it 'displays a map (needs internet)', js:true do
        	visit '/events'
            expect(page).to have_css '.gm-style'
        end
    end
end