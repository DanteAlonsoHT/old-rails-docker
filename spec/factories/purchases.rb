FactoryGirl.define do
  factory :purchase do
    price_at_sale { rand(100..500) }
    purchased_at { Time.now }
    association :product
    association :customer
  end
end
