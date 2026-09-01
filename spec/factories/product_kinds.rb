FactoryBot.define do
  factory :product_kind do
    sequence(:name) { |n| "Kind #{n}" }
    material { "resin" }
    description { "A collectible piece." }
  end
end
