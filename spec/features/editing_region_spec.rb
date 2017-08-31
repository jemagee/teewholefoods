require 'rails_helper'

RSpec.feature "Editing a region" do
	let(:region) {FactoryGirl.create(:region)}
	let!(:region2) {FactoryGirl.create(:region)}


	before  do
		visit region_path(region)
		click_link "Edit #{region.name}"
	end

	scenario "Works properly" do

		fill_in "region[name]", with: "New region name"
		click_button "Update Region"

		within("div.alert-success") do 
			expect(page).to have_content("The region was successfully updated")
		end

		expect(page).to have_content("New region name")
		expect(current_path).to eq region_path(region)
	end

	scenario "fails with a blank name" do

		fill_in "region[name]", with: ""
		click_button "Update Region"

		within("div.alert-warning") do
			expect(page).to have_content("The region was not updated")
		end

		within("div.errors") do
			expect(page).to have_content("2 errors prevented")
			expect(page).to have_content("Region name can't be blank")
		end
	end

	scenario "fails with too short name" do

		fill_in "region[name]", with: "aa"
		click_button "Update Region"

		within("div.errors") do
			expect(page).to have_content("1 error prevented")
			expect(page).to have_content("Region name must be at least 3 letters")
		end
	end

	scenario "fails with a duplicated name" do
		fill_in "region[name]", with: region2.name
		click_button "Update Region"

		within("div.errors") do
			expect(page).to have_content("Region name has already been taken")
		end
	end
end
