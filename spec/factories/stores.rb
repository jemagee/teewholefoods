FactoryGirl.define do
  factory :store do
    sequence(:name) {|n| "Store Name#{n}"}
    sequence(:number) {|n| 10000+n}
  end
end
