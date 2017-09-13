require 'rails_helper'

RSpec.feature "Closing (instead of destroying) a store" do

	let!(:region) {FactoryGirl.create(:region)}
	let!(:store) {FactoryGirl.create(:store, region: region)}
	let!(:store2) {FactoryGirl.create(:store, region: region)}

	before {visit store_path(store)}

	scenario "Works Properly" do

		click_link "Close Store"
		expect(page).to have_content("The store was marked as closed")
		expect(current_path).to eq region_path(region)
		store.reload
		expect(store.open).to eq false
	end
end

