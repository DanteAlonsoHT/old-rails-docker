FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" } # Generar nombres únicos
    association :created_by, factory: :administrator
    association :updated_by, factory: :administrator
  end
end
