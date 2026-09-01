FactoryBot.define do
  factory :product do
    association :character
    association :product_kind
    stock { 5 }
    price { 49.99 }
    cost { 20.00 }
    aditional_info { "Ships in 3 days." }

    trait :sold_out do
      stock { 0 }
    end
  end
end
