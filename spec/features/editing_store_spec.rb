require 'rails_helper'

RSpec.feature "Editing a store" do

	5.times do |n|
		let!("region#{n}") {FactoryGirl.create(:region)}
	end

	let(:store) {FactoryGirl.create(:store, region: region0)}
	let!(:store2) {FactoryGirl.create(:store, region: region0)}

	before do
		visit store_path(store)
		click_link "Edit Store"
	end

	scenario "Works with proper context" do

		fill_in "store[name]", with: "New Store Name"
		fill_in "store[number]", with: 99999
		find("select#store_region_id").select("#{region4.name}")
		click_button "Update Store"

		within("div.alert-success") do
			expect(page).to have_content("The store has been updated")
		end

		within("#store_name") do
			expect(page).to have_content("New Store Name")
		end

		within("div#store_number") do
			expect(page).to have_content(99999)
		end

		within("div#store_region") do
			expect(page).to have_content(region4.name)
		end
	end

	scenario "fails with a blank name" do

		fill_in "store[name]", with: ""
		click_button "Update Store"

		within("div.alert-warning") do
			expect(page).to have_content("The store was not updated")
		end

		within("div.errors") do
			expect(page).to have_content("Store name can't be blank")
		end
	end

	scenario "fails with a short name" do

		fill_in "store[name]", with: "aa"
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content("Store name is too short")
		end
	end

	scenario "fails with a non unique name" do

		fill_in "store[name]", with: store2.name.upcase
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content("Store name has already been taken")
		end
	end

	scenario "fails with no store number" do

		fill_in "store[number]", with: ""
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content("Store number can't be blank")
		end
	end

	scenario "faills with invalid store numbers" do

		fill_in "store[number]", with: 9999
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content("Store number must be 5 digits")
		end
	end

	scenario "fails with a noninteger store numbers" do

		fill_in "store[number]", with: 12345.67
		click_button "Update Store"

		within("div.errors") do 
			expect(page).to have_content("Store number must be an integer")
		end
	end

	scenario "fails with an already existing store number" do

		fill_in "store[number]", with: store2.number
		click_button "Update Store"

		within("div.errors") do
			expect(page).to have_content("Store number has already been taken")
		end
	end
end