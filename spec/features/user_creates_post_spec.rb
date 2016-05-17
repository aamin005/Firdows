require "rails_helper"

RSpec.describe "Creating post" do 
	scenario "successfully" do 
		visit root_path
		click_on "Post a poster"

		fill_in "Title", with: "My first poster"
		fill_in "Body", with: "Some the best poster for your love"
		click_on "Publish"

		expect(page).to have_content "My first poster"
	end

	scenario "unsuccessfully" do 
		visit root_path
		click_on "Post a poster"

		fill_in "Title", with: "My second poster"
		fill_in "Body", with: ""
		click_on "Publish"

		expect(page).to have_css ".error"
	end
end