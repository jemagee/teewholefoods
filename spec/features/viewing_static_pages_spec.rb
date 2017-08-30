require 'rails_helper'

RSpec.feature "Static Pages" do

	scenario "The root goes to the index page" do

		visit root_path

		expect(current_path).to eq root_path
		expect(page).to have_content("Welcome to the Teeccino Whole Foods Portal")
		expect(page).to have_link("Click Here to Login")
	end
end