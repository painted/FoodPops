require 'rails_helper'

describe 'Users' do

	context 'logged out' do 

		create_bob

		it 'is asked to login in order to see the list of users' do 
			visit foodies_path
			expect(page).not_to have_content 'Bob'
			expect(page).to have_content 'Sign in'
		end

	end

	context 'logged in' do 

		create_bob
		before do 
			peter = Foody.create email: 'p@s.com', password: '12345678', password_confirmation: '12345678', username: 'peter'
			sam = Foody.create email: 's@s.com', password: '12345678', password_confirmation: '12345678', username: 'sam'
			login_as bob
		end

		it 'can see a list of all users' do 
			visit foodies_path
			expect(page).to have_content 'Bob'
			expect(page).to have_content 'peter'
			expect(page).to have_content 'sam'
		end

	end

	context 'account set up' do 

		it 'can add a photo avatar' do 
			visit new_foody_registration_path
			fill_in 'Email', with: 's@s.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			attach_file 'Avatar', Rails.root.join('spec/images/paintedicon.png')
			click_button 'Sign up'
			visit foodies_path
			expect(page).to have_css 'img.uploaded-avatar'
		end
	end

	context 'account editing' do 

		before do 
			visit new_foody_registration_path
			fill_in 'Email', with: 's@s.com'
			fill_in 'Password', with: '12345678'
			fill_in 'Password confirmation', with: '12345678'
			attach_file 'Avatar', Rails.root.join('spec/images/paintedicon.png')
			click_button 'Sign up' 
			click_link 'Edit Account'
		end

		it 'can change the avatar image' do 
			attach_file 'Avatar', Rails.root.join('spec/images/paintedicon.png')
			fill_in 'Current password', with: '12345678'
			click_button 'Update'
			expect(page).to have_content 'Your account has been updated successfully.'
		end
	end
end