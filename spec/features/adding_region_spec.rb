require 'rails_helper'

RSpec.feature "Adding a region" do

	before {visit new_region_path}

	scenario "Works when done properly" do

		fill_in "region[name]", with: "New Region"
		click_button "Add Region"

		within("div.alert-success") do
			expect(page).to have_content("The region was added")
		end
		expect(page).to have_content("New Region")
		expect(current_path).to eq regions_path
	end

	scenario "Fails when an empty name is submitted" do

		click_button "Add Region"

		within("div.alert-warning") do
			expect(page).to have_content("The region was not added")
		end

		within("div.errors") do
			expect(page).to have_content("Region name can't be blank")
		end
	end

	scenario "Fails properly with a too short name" do

		fill_in "region[name]", with: "aa"
		click_button "Add Region"

		within("div.errors") do
			expect(page).to have_content("1 error prevented this region from being entered")
			expect(page).to have_content("Region name must be at least 3 letters")
		end
	end

	scenario "Fails with non unique name" do
		Region.create(name: "New Region")

		fill_in "region[name]", with: "NEW REGION"
		click_button "Add Region"

		within("div.errors") do
			expect(page).to have_content("1 error")
			expect(page).to have_content("Region name has already been taken")
		end
	end
end