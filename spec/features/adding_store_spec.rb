require 'rails_helper'

RSpec.feature "Adding a Store" do

	5.times do |n|
		let!("region#{n}") {FactoryGirl.create(:region)}
	end

	scenario "Works Properly" do

		visit new_store_path

		fill_in "store[name]", with: "New Store Name"
		fill_in "store[number]", with: 12345
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.alert-success") do
			expect(page).to have_content("The store was added")
		end
		expect(page).to have_content("New Store Name")
		expect(page).to have_content("#{region4.name}")
		expect(page).to have_content(12345)
		expect(page).to have_content("Status: Open")
		expect(region4.stores.count).to eq 1
	end
end