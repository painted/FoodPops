require 'rails_helper'

context 'logged out' do

    before do 
        @bob = Foody.create(email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob')
        @bob.events.create(title: 'test event', description: 'test description', 
            start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
        login_as @bob
    end

    it 'cannot Edit Reviews' do
        visit '/events/1'
        leave_review('Amazing', 6)
        logout(:bob)
        expect(page).to have_content 'test event'
        expect(page).to have_content 'Amazing'
        expect(page).not_to have_link 'Edit review'
    end
end

# context 'logged in as the review creator' do
#     before do  
#         @bob = Foody.create(email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob')
#         @bob.events.create(title: 'test event', description: 'test description', 
#             start_date: Time.new(2014, 11, 5, 12, 0, 0, "+00:00"), end_date: Time.new(2014, 11, 7, 14, 0, 0, "+00:00"))
#         login_as @bob
#     end

#     it 'can edit restaurants' do
#         visit '/events/2'
#         click_link 'Edit Royal China'
#         fill_in 'Name', with: 'Royal China Queensway'
#         click_button 'Update Restaurant'
#         expect(page).to have_content 'Royal China Queensway'
#     end
# end

# context 'logged in as another restaurant creator' do 

#     before do
#         will = User.create(email: 'will@example.com', password: '12345678', password_confirmation: '12345678')
#         bob = User.create(email: 'bob@example.com', password: '12345678', password_confirmation: '12345678')
#         login_as will
#         bob.restaurants.create(name: 'Royal China', cuisine: 'Chinese')
#     end

#     it 'cannot edit restaurants' do
#         visit '/restaurants'
#         click_link 'Edit Royal China'
#         fill_in 'Name', with: 'Royal China Queensway'
#         click_button 'Update Restaurant' 
#         expect(page).to have_content 'You do not have permission to edit the restaurant: Royal China'
#     end
# end