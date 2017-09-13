require 'rails_helper'

RSpec.feature "Adding an item" do

	let!(:item) {FactoryGirl.create(:item)}

	before {visit new_item_path}

	scenario "works properly" do

		fill_in "item[name]", with: "new item name"
		fill_in "item[number]", with: 79523940000
		click_button "Add Item"

		within("div.alert-success") do
			expect(page).to have_content("The item was added")
		end

		expect(page).to have_content("new item name")
		expect(page).to have_content(79523940000)
	end

	scenario "fails without a name" do

		fill_in "item[number]", with: 79523940000
		click_button "Add Item"

		within("div.alert-warning") do
			expect(page).to have_content("The item was not added")
		end

		within("div.errors") do
			expect(page).to have_content("Item name can't be blank")
		end
	end

	scenario "fails with a too short name" do

		fill_in "item[name]", with: "newt"
		fill_in "item[number]", with: 79523940000
		click_button "Add Item"

		within("div.errors") do
			expect(page).to have_content("Item name must be at least 5 letters")
		end
	end

	scenario "fails with no upc number" do
		fill_in "item[name]", with: "new item name"
		click_button "Add Item"

		within("div.errors") do
			expect(page).to have_content("Item UPC can't be blank")
		end
	end

	scenario "fails with non number number" do

		fill_in "item[name]", with: "new item name"
		fill_in "item[number]", with: "aadsfadfajlsdk"
		click_button "Add Item"

		within("div.errors")  do
			expect(page).to have_content("Item UPC must be a number")
		end
	end

	scenario "fails with a UPC number outside the range" do

		fill_in "item[name]", with: "new item name"
		fill_in "item[number]", with: 9999999999
		click_button "Add Item"

		within("div.errors") do 
			expect(page).to have_content("Item UPC is not valid")
		end
	end

	scenario "fails with a non unique UPC number" do
		fill_in "item[name]", with: "new item name"
		fill_in "item[number]", with: item.number
		click_button "Add Item"

		within("div.errors") do
			expect(page).to have_content("Item UPC has already been taken")
		end
	end
end