require 'rails_helper'

RSpec.describe Store, type: :model do
  it {should belong_to(:region)}
  it {should validate_presence_of(:name)}
  it {should validate_length_of(:name).is_at_least(3)}
  it {should validate_uniqueness_of(:name).case_insensitive}
  it {should validate_presence_of(:number)}
  it {should validate_numericality_of(:number).only_integer}
  it {should validate_inclusion_of(:number).in_range(10000..99999)}

  it "a new record should have a default open value of true" do
  	new_store = Store.new
  	expect(new_store.open).to eq true
  end
end
