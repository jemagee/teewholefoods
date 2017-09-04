require 'rails_helper'

RSpec.feature "Adding a Store" do

	5.times do |n|
		let!("region#{n}") {FactoryGirl.create(:region)}
	end

	let!(:store) {FactoryGirl.create(:store, region: region3)}

	before {visit new_store_path}

	scenario "Works Properly" do

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

	scenario "fails with blank store name" do

		fill_in "store[number]", with: 12345
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.alert-warning") do
			expect(page).to have_content("The store was not added")
		end

		within("div.errors") do
			expect(page).to have_content("2 errors prevented this store from being entered")
			expect(page).to have_content("Store name can't be blank")
		end
	end

	scenario "fails with a too short store name" do

		fill_in "store[name]", with: "Ne"
		fill_in "store[number]", with: 12345
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.alert-warning") do
			expect(page).to have_content("The store was not added")
		end

		within("div.errors") do
			expect(page).to have_content("Store name is too short")
		end
	end

	scenario "fails with a duplicated store name" do

		fill_in "store[name]", with: store.name.upcase
		fill_in "store[number]", with: 12345
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.errors") do 
			expect(page).to have_content("Store name has already been taken")
		end
	end

	scenario "fails with a short store number" do

		fill_in "store[name]", with: "new store name"
		fill_in "store[number]", with: 9999
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.errors") do 
			expect(page).to have_content("Store number must be 5 digits")
		end
	end

	scenario "fails with non-unique store number" do

		fill_in "store[name]", with: "New Store Name"
		fill_in "store[number]", with: store.number
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.errors") do
			expect(page).to have_content("Store number has already been taken")
		end
	end

	scenario "fails with non-integer store number" do

		fill_in "store[name]", with: "New Store Name"
		fill_in "store[number]", with: 1345.6
		find("select#store_region_id").select("#{region4.name}")
		click_button "Add Store"

		within("div.errors") do
			expect(page).to have_content("Store number must be an integer")
		end
	end
end