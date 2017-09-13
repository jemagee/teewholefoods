FactoryGirl.define do
  factory :item do
    sequence(:name) {|n| "Item#{n}"}
    sequence(:number) {|n| 10000000000+n}
  end
end
