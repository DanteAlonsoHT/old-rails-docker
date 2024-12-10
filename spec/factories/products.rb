FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" } # Generar nombres únicos
    description { "Sample description" }
    price { rand(100..500) }
    association :created_by, factory: :administrator
    association :updated_by, factory: :administrator

    after(:create) do |product|
      create_list(:product_category, 2, product: product)
    end
  end
end
