require "rails_helper"

RSpec.describe "Creating post" do 
	let(:user) {User.create(username: "exampleuser", email: "example@user.com", password: 'password', password_confirmation: 'password')}
	
	scenario "successfully" do 
		sign_in user
		visit root_path
		click_on "Post a poster"

		fill_in "Title", with: "My first poster"
		fill_in "Body", with: "Some the best poster for your love"
		click_on "Publish"

		within(".posts") do
			expect(page).to have_content "My first poster"
			expect(page).to have_content "exampleuser"
		end
	end

	scenario "unsuccessfully" do 
		sign_in user
		visit root_path
		click_on "Post a poster"

		fill_in "Title", with: "My second poster"
		fill_in "Body", with: ""
		click_on "Publish"

		expect(page).to have_css ".error"
	end

	scenario "non-logged in user connot create post" do
		visit root_path
		click_on "Post a poster"

		expect(current_path).to eq(new_user_session_path)
	end
end