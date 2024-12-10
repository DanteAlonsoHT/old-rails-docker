FactoryGirl.define do
  factory :administrator do
    sequence(:email) { |n| "admin#{n}@example.com" }
    name { "Admin #{rand(1000)}" }
    password { "password-#{rand(1000)}" }
  end
end
