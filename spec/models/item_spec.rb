require 'rails_helper'

RSpec.describe Item, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_length_of(:name).is_at_least(5)}
  it {should validate_presence_of(:number)}
  it {should validate_numericality_of(:number).only_integer}
  it {should validate_uniqueness_of(:number)}
  it {should validate_inclusion_of(:number).in_range(10000000000..99999999999)}
end
