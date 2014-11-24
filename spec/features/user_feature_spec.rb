require 'rails_helper'

describe 'Users' do

	context 'logged out' do 

		before do  
			bob = Foody.create email: 'b@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
		end

		it 'is asked to login in order to see the list of users' do 
			visit foodies_path
			expect(page).not_to have_content 'bob'
		end

	end

	context 'logged in' do 

		before do  
			bob = Foody.create email: 'b@s.com', password: '12345678', password_confirmation: '12345678', username: 'bob'
			peter = Foody.create email: 'p@s.com', password: '12345678', password_confirmation: '12345678', username: 'peter'
			sam = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'sam'
			login_as bob
		end

		it 'can see a list of all users' do 
			visit foodies_path
			expect(page).to have_content 'bob'
			expect(page).to have_content 'peter'
			expect(page).to have_content 'sam'
		end


	end

end